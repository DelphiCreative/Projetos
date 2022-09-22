program Organizador;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.Types,
  System.IOUtils,
  System.SysUtils;

procedure Organizar;
var
   Arquivos : TStringDynArray;
   PathArquivo,
   Arquivo : String;
begin
   Writeln(TPath.GetFileName(ParamStr(0)));
   Writeln(GetCurrentDir);

   Arquivos := TDirectory.GetFiles(GetCurrentDir);
   for Arquivo in Arquivos do begin
      if TPath.GetFileName(ParamStr(0)) <> TPath.GetFileName(Arquivo) then begin
         PathArquivo := TPath.Combine(GetCurrentDir,TPath.GetExtension(Arquivo));
         if not DirectoryExists(PathArquivo) then
            CreateDir(PathArquivo);
         try
           TFile.Move(Arquivo, TPath.Combine(PathArquivo,TPath.GetFileName(Arquivo)) );
         except
           Writeln('Não foi possível mover o arquivo:' + Arquivo);
         end;
       //Writeln(TPath.GetExtension(Arquivo));

     end;
   end;

end;

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  Organizar;
  Readln;
end.
