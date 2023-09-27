/*O Parse.Query fornece vários métodos para filtrar resultados de consultas, incluindo:

equalTo(key, value): retorna todos os objetos com um valor específico para a chave dada.
notEqualTo(key, value): retorna todos os objetos com um valor diferente do especificado para a chave dada.
greaterThan(key, value): retorna todos os objetos com um valor maior do que o especificado para a chave dada.
greaterThanOrEqualTo(key, value): retorna todos os objetos com um valor maior ou igual ao especificado para a chave dada.
lessThan(key, value): retorna todos os objetos com um valor menor do que o especificado para a chave dada.
lessThanOrEqualTo(key, value): retorna todos os objetos com um valor menor ou igual ao especificado para a chave dada.
containedIn(key, values): retorna todos os objetos com um valor contido em uma matriz de valores especificados para a chave dada.
notContainedIn(key, values): retorna todos os objetos com um valor que não está contido em uma matriz de valores especificados para a chave dada.
exists(key): retorna todos os objetos com uma chave especificada que existe.
doesNotExist(key): retorna todos os objetos com uma chave especificada que não existe.
matches(key, regex, modifiers): retorna todos os objetos com um valor que corresponde a uma expressão regular especificada para a chave dada.
matchesKeyInQuery(key, keyInQuery, query): retorna todos os objetos com um valor que corresponde a uma chave especificada em uma consulta dada.
doesNotMatchKeyInQuery(key, keyInQuery, query): retorna todos os objetos com um valor que não corresponde a uma chave especificada em uma consulta dada.
relatedTo(key, pointer): retorna todos os objetos relacionados a um ponteiro especificado para a chave dada.
Você pode combinar vários filtros para obter resultados mais precisos. Por exemplo, você pode encadear vários métodos de filtro para encontrar todos os objetos com um valor maior do que x e menor do que y.
*/

const Produto = Parse.Object.extend("Produto")
const ID = Parse.Object.extend("AutoID")
const Marca = Parse.Object.extend("Marca")
const UserLog = Parse.Object.extend("User")


Parse.Cloud.define("hello", (request) => {
    return ("Hello," + request.params.nome);
});

Parse.Cloud.define("login", async (req) => {
    if (!req.params.username || req.params.username === "") {
        throw "Nome de usuário não informado.";
    }

    if (!req.params.password || req.params.password === "") {
        throw "Senha não informada.";
    }

    try {
        const user = await Parse.User.logIn(req.params.username, req.params.password);
        return user;
    } catch (error) {
        const errorMessages = {
            101: "Nome de usuário ou senha inválidos.",
            // Adicione mais traduções de mensagens de erro conforme necessário
        };

        const errorCode = error.code || 0;
        const translatedError = errorMessages[errorCode] || "Erro desconhecido.";

        throw new Parse.Error(errorCode, translatedError);
    }
});

Parse.Cloud.define("signUp", async (req) => {

    if (!req.params.username || req.params.username === "") {
        throw "Nome de usuário não informado.";
    }

    if (!req.params.password || req.params.password === "") {
        throw "Senha não informada.";
    }

    if (req.params.email) {
        const emailRegex = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        if (!emailRegex.test(req.params.email)) {
            throw new Error("Endereço de e-mail inválido");
        }
    }

    const user = new Parse.User()
    user.set("email", req.params.email)
    user.set("password", req.params.password)
    user.set("username", req.params.username)
    user.set("profissao", req.params.telefone)

    try {
        const saveUser = await user.signUp(null, { useMasterKey: true });
        return saveUser;
    } catch (error) {
        if (error.code === 202) {
            throw new Error("Conta já existe para este nome de usuário.");
        } else if (error.code === 203) {
            throw new Error("Conta já existe para este endereço de e-mail.");
        } else {
            throw new Error("Ocorreu um erro durante o cadastro.");
        }
    }
});

// Função para obter o próximo ID disponível para uma classe
async function getNextId(className) {
    const queryID = new Parse.Query(ID);
    queryID.equalTo("tabela", className);
    const idObject = await queryID.first({ useMasterKey: true });

    if (!idObject) {
        throw `ID não encontrado para a classe ${className}`;
    }

    const nextId = idObject.get("nextId");
    idObject.increment("nextId");
    await idObject.save(null, { useMasterKey: true });

    return nextId;
}

// Função para obter/incluir uma marca
async function findOrCreateMarca(marcaDescricao) {
    const queryMarca = new Parse.Query("Marca");
    queryMarca.equalTo("descricao", marcaDescricao.toUpperCase());
    let marca = await queryMarca.first({ useMasterKey: true });

    if (!marca) {
        marca = new Marca();
        marca.set("descricao", marcaDescricao.toUpperCase());
        await marca.save(null, { useMasterKey: true });
    }

    return marca;
}


async function validateUser(idUsuario) {
    if (!idUsuario || idUsuario === "") {
        throw "Usuário não autenticado";
    }

    const userQuery = new Parse.Query(UserLog);
    userQuery.equalTo("objectId", idUsuario);

    const user = await userQuery.first({ useMasterKey: true });

    if (!user) {
        throw "Usuário não encontrado";
    }
}


Parse.Cloud.define("createOrUpdateProduct", async (req) => {
  
    const idUsuario = req.params.idUsuario;
    await validateUser(idUsuario);

    const produtoId = req.params.idProduto;
    const preco = req.params.preco;
    const descricao = req.params.descricao;
    const estoque = req.params.estoque;
    const marcaDescricao = req.params.marca;


    if (!descricao || descricao === "") {
        throw "Descrição do produto é obrigatório";
    }

    if (!preco || preco === "") {
        throw "Preço é obrigatório";
    }

    let produto;
    let msg;

    if (!produtoId || produtoId === "") {
        const nextProductId = await getNextId("Produto");
        produto = new Produto();
        produto.set("idProduto", nextProductId);
        msg = "Produto incluído com sucesso";
    } else {
        const queryProduto = new Parse.Query(Produto);
        queryProduto.equalTo("idProduto", produtoId);
        produto = await queryProduto.first({ useMasterKey: true });

        if (!produto) {
            produto = new Produto();
            produto.set("idProduto", produtoId);
            msg = "Produto incluído com sucesso";
        } else {
            msg = "Produto atualizado com sucesso";            
        }
    }

    produto.set("preco", parseFloat(preco));
    produto.set("descricao", descricao);
    produto.set("estoque", parseInt(estoque));
    produto.set("deletedAt", null);

    if (marcaDescricao) {
        const marca = await findOrCreateMarca(marcaDescricao);
        produto.set("marca", marca);
    }

    await produto.save(null, { useMasterKey: true });

    const responseJSON = {
        idProduto: produto.get("idProduto"),
        sucess: msg
    };

    return responseJSON;
});

Parse.Cloud.define("destroyProduct", async (req) => {
    const produtoId = req.params.idProduto;

    if (!produtoId || produtoId === "") {
        throw "ID do produto é obrigatório";
    }

    const queryProduto = new Parse.Query(Produto);
    queryProduto.equalTo("idProduto", produtoId);
    const produto = await queryProduto.first({ useMasterKey: true });

    if (!produto) {
        throw "Produto não encontrado com o ID fornecido";
    }

    await produto.destroy({ useMasterKey: true });

    const responseJSON = {
        idProduto: produto.get("idProduto"),
        success: "Produto excluído com sucesso"
    };

    return responseJSON;
});


Parse.Cloud.define("deleteProduct", async (req) => {
    const produtoId = req.params.idProduto;

    if (!produtoId || produtoId === "") {
        throw "ID do produto é obrigatório";
    }

    const queryProduto = new Parse.Query(Produto);
    queryProduto.equalTo("idProduto", produtoId);
    const produto = await queryProduto.first({ useMasterKey: true });

    if (!produto) {
        throw "Produto não encontrado com o ID fornecido";
    }

    // Define o campo 'deletedAt' com a data atual
    produto.set("deletedAt", new Date());
    
    // Salva o objeto para realizar a "exclusão suave"
    await produto.save(null, { useMasterKey: true });

    const responseJSON = {
        idProduto: produto.get("idProduto"),
        success: "Produto excluído com sucesso"
    };

    return responseJSON;
});


// Função para aplicar condição de pesquisa
function applySearchCondition(query, field, value) {
    let fieldWithoutPercent = value;

    if (value) {
        if (value.endsWith("%")) {
            fieldWithoutPercent = value.replace(/%/g, ""); // Remove o "%"
            query.contains(field, fieldWithoutPercent);
        } else if (value.startsWith("%")) {
            fieldWithoutPercent = value.replace(/%/g, ""); // Remove o "%"
            query.startsWith(field, fieldWithoutPercent);
        } else {
            query.equalTo(field, value);
        }
    }
    return fieldWithoutPercent;
}

// Função para aplicar condição de pesquisa a campos de texto
function applyTextSearchCondition(query, field, value) {
    let fieldWithoutPercent = value;

    if (value) {
        if (value.endsWith("%") && value.startsWith("%")  ) {
            // Se o valor terminar com "%", use o operador "contains"
            fieldWithoutPercent = value.replace(/%/g, ""); // Remove o "%"
            query.contains(field, fieldWithoutPercent);
        } else if (value.endsWith("%")) {
            // Se o valor começar com "%", use o operador "startsWith"
            fieldWithoutPercent = value.replace(/%/g, ""); // Remove o "%"
            query.startsWith(field, fieldWithoutPercent);
        } else {
            query.equalTo(field, value);
        }
    }

    return fieldWithoutPercent;
}

// Função para aplicar condição de pesquisa a campos de relacionamento (ponteiros)
async function applyPointerSearchCondition(query, pointer, field, value) {
    let fieldWithoutPercent = value;

    if (value) {
        if (value.endsWith("%") && value.startsWith("%")  ) {
            // Se o valor terminar com "%", use o operador "contains" nos objetos relacionados
            fieldWithoutPercent = value.replace(/%/g, ""); // Remove o "%"
            const relatedQuery = new Parse.Query(pointer);
            relatedQuery.contains(field.split(".")[1], fieldWithoutPercent);
            const relatedObjects = await relatedQuery.find({ useMasterKey: true });
            query.containedIn(field.split(".")[0], relatedObjects);
        } else if (value.endsWith("%")) {
            // Se o valor começar com "%", use o operador "startsWith"
            fieldWithoutPercent = value.replace(/%/g, ""); // Remove o "%"
            query.startsWith(field, fieldWithoutPercent);
        } else {
            // Trate como uma correspondência exata nos objetos relacionados
            const relatedQuery = new Parse.Query(pointer);
            relatedQuery.equalTo(field.split(".")[1], value);
            const relatedObject = await relatedQuery.first({ useMasterKey: true });
            if (relatedObject) {
                query.equalTo(field.split(".")[0], relatedObject);
            }
        }
    }

    return fieldWithoutPercent;
}


Parse.Cloud.define("getProductList", async (req) => {
    const query = new Parse.Query(Produto);
    query.include("marca");

    let page = req.params.page;
    let limite = req.params.limit;
    let orderBy = req.params.orderBy;
    const produtoDescricao = req.params.descricao;
    const marcaNome = req.params.marca;

    if (page === undefined || isNaN(page) || page <= 0) {
        page = 1;
    }

    if (limite === undefined || isNaN(limite)) {
        limite = 10;
    }

    if (orderBy === undefined || orderBy === "") {
        orderBy = "idProduto";
    }

    query.ascending(orderBy);
    query.limit(limite);
    query.skip((page - 1) * limite);

    // Função para transformar o campo de pesquisa da descrição
    const produtoDescricaoSemPercent = applyTextSearchCondition(query, "descricao", produtoDescricao);

    // Chame a função para transformar o campo de pesquisa da marca
    //const marcaNomeSemPercent = applyPointerSearchCondition(query, Marca , "marca.descricao", marcaNome);

    let marcaNomeWithoutPercent = marcaNome
    if (marcaNome) {
        if (marcaNome.endsWith("%") || marcaNome.endsWith("%"))   {
            // Se o nome da marca terminar com "%", use o operador "contains" para a marca
            marcaNomeWithoutPercent = marcaNome.replace(/%/g, ""); // Remova os "%"
            const marcaQuery = new Parse.Query(Marca);
            marcaQuery.contains("descricao", marcaNomeWithoutPercent);
            const marcas = await marcaQuery.find({ useMasterKey: true });
            query.containedIn("marca", marcas);
        } else if (marcaNome.endsWith("%")) {
            // Se o nome da marca começar com "%", use o operador "startsWith" para a marca
            marcaNomeWithoutPercent = marcaNome.replace(/%/g, ""); // Remova os "%"
            query.startsWith("marca.descricao", marcaNomeWithoutPercent);
        } else {
            // Se não incluir "%" no início ou no final, trate como uma correspondência exata para a marca
            const marcaQuery = new Parse.Query(Marca);
            marcaQuery.equalTo("descricao", marcaNome);
            const marca = await marcaQuery.first({ useMasterKey: true });
            if (marca) {
                query.equalTo("marca", marca);
            }
        }
    }
   
    const produtos = await query.find({ useMasterKey: true });

    return produtos.map(function (p) {
        p = p.toJSON();

        return {
            idProduto: p.idProduto,
            descricao: p.descricao,
            preco: 'R$ ' + p.preco.toLocaleString('pt-BR', { minimumFractionDigits: 2, maximumFractionDigits: 2 }),
            estoque: p.estoque,
            marca: p.marca != null ? p.marca.descricao : ""
            //produtoDescricaoWithoutPercent: produtoDescricaoSemPercent
            //marcaNomeWithoutPercent: marcaNomeSemPercent
        };
    });
});


Parse.Cloud.define("resetDeletedAtForAllProducts", async (req) => {
    const queryProduto = new Parse.Query(Produto);

    // Filtra produtos onde o campo 'deletedAt' não é nulo
    queryProduto.exists("deletedAt");

    try {
        const produtos = await queryProduto.find({ useMasterKey: true });

        for (const produto of produtos) {
            produto.set("deletedAt", null);
            await produto.save(null, { useMasterKey: true });
        }

        return "Todos os produtos foram atualizados com sucesso.";
    } catch (error) {
        throw `Erro ao atualizar os produtos: ${error}`;
    }
});
