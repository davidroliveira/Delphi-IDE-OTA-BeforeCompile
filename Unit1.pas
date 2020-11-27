unit Unit1;

interface

procedure Register;

implementation

uses
  System.SysUtils, Vcl.Dialogs, ToolsAPI;

type
  //TSillyOTAObject = class(TInterfacedObject, IOTAIDENotifier)
  TSillyOTAObject = class(TInterfacedObject, IOTACompileNotifier)
//  private
//    { Private declarations }
//  protected
//    procedure AfterSave;
//    { This function is called immediately before the item is saved. This is not
//      called for IOTAWizard }
//    procedure BeforeSave;
//    { The associated item is being destroyed so all references should be dropped.
//      Exceptions are ignored. }
//    procedure Destroyed;
//    { This associated item was modified in some way. This is not called for
//      IOTAWizards }
//    procedure Modified;
//
//    { This procedure is called for many various file operations within the
//      IDE }
//    procedure FileNotification(NotifyCode: TOTAFileNotification;
//      const FileName: string; var Cancel: Boolean);
//    { This function is called immediatately before the compiler is invoked.
//      Set Cancel to True to cancel the compile }
//    procedure BeforeCompile(const Project: IOTAProject; var Cancel: Boolean);
//    { This procedure is called immediately following a compile.  Succeeded
//      will be true if the compile was successful }
//    procedure AfterCompile(Succeeded: Boolean);
  protected
    Procedure ProjectCompileStarted(const Project: IOTAProject; Mode: TOTACompileMode);
    Procedure ProjectCompileFinished(const Project: IOTAProject; Result: TOTACompileResult);
    Procedure ProjectGroupCompileStarted(Mode: TOTACompileMode);
    Procedure ProjectGroupCompileFinished(Result: TOTACompileResult);

    procedure DebugMsg(const Mensagem: string; const Project: IOTAProject); overload;
    procedure DebugMsg(const Mensagem: string); overload;
  public
    { Public declarations }
  end;
//
//
//{ TSillyOTAObject }
//
//procedure TSillyOTAObject.AfterSave;
//begin
//
//end;
//
//procedure TSillyOTAObject.BeforeSave;
//begin
//
//end;
//
//procedure TSillyOTAObject.Destroyed;
//begin
//
//end;
//
//procedure TSillyOTAObject.Modified;
//begin
//
//end;
//
//procedure TSillyOTAObject.FileNotification(NotifyCode: TOTAFileNotification;
//  const FileName: string; var Cancel: Boolean);
//begin
//
//end;
//
//procedure TSillyOTAObject.BeforeCompile(const Project: IOTAProject;
//  var Cancel: Boolean);
//begin
//  ShowMessage('BeforeCompile!');
//end;
//
//procedure TSillyOTAObject.AfterCompile(Succeeded: Boolean);
//begin
//  ShowMessage('AfterCompile!');
//end;


Const
  strCompileMode : Array[Low(TOTACompileMode)..High(TOTACompileMode)] Of String = ('Make', 'Build', 'Check', 'Make Unit');
  strCompileResult : Array[Low(TOTACompileResult)..High(TOTACompileResult)] of String = ('Failed', 'Succeeded', 'Background');

procedure TSillyOTAObject.DebugMsg(const Mensagem: string);
begin
  ShowMessage(Mensagem);
end;

procedure TSillyOTAObject.DebugMsg(const Mensagem: string; const Project: IOTAProject);
begin
  ShowMessage(Mensagem);
end;

Procedure TSillyOTAObject.ProjectCompileStarted(const Project: IOTAProject; Mode: TOTACompileMode);
Begin
  DebugMsg(Format('Compile Started (%s)...', [strCompileMode[Mode]]), Project);
End;

Procedure TSillyOTAObject.ProjectCompileFinished(const Project: IOTAProject; Result: TOTACompileResult);
Begin
  DebugMsg(Format('Compile Finished (%s)...', [strCompileResult[Result]]), Project);
End;

Procedure TSillyOTAObject.ProjectGroupCompileStarted(Mode: TOTACompileMode);
Begin
  DebugMsg(Format('Group Compile Finished (%s)...', [strCompileMode[Mode]]));
End;

Procedure TSillyOTAObject.ProjectGroupCompileFinished(Result: TOTACompileResult);
Begin
  DebugMsg(Format('Group Compile Finished (%s)...', [strCompileResult[Result]]));
End;
var
  Index: Integer;

procedure Register;
begin
  //Index := (BorlandIDEServices as IOTAServices).AddNotifier(TSillyOTAObject.Create);
  Index := (BorlandIDEServices as IOTACompileServices).AddNotifier(TSillyOTAObject.Create);
end;

initialization

finalization
  //(BorlandIDEServices as IOTAServices).RemoveNotifier(Index);
  (BorlandIDEServices As IOTACompileServices).RemoveNotifier(Index);


end.
