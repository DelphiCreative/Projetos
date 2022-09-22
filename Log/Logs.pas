unit Logs;

interface

uses
   System.IOUtils
   VCL.Forms,
   VCL.Dialogs;

var
  teste: string;

implementation

initialization


   teste := 'Teste';
   showmessage(teste);
end.
