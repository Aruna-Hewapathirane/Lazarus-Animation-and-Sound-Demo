unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, Process;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Image2: TImage;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure PlaySound(FileName: string);
  private

  public

  end;

var
  Form1: TForm1;
  Increasing:Boolean;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if Increasing then
  begin
    if Self.Height < 500 then
      Self.Height := Self.Height + 2
    else
      begin
        Button1.Caption:='Roll it back up';
        Form1.Caption:='The Rest Is History';
        Timer1.Enabled := False; // Stop the timer when the height reaches 500
      end;
  end
  else
  begin
    if Self.Height > 47 then
      Self.Height := Self.Height - 2
    else
      begin
      Button1.Caption:='Start Demo';
      Form1.Caption:='The Ostentatious Demo ';
      Timer1.Enabled := False; // Stop the timer when the height reaches 20
      end;
  end;
end;

procedure TForm1.PlaySound(FileName: string);
  var
  AProcess: TProcess;
begin
  AProcess := TProcess.Create(nil);
  try
    AProcess.Executable := 'aplay';
    AProcess.Parameters.Add(FileName);
    AProcess.Options := AProcess.Options; // + [poWaitOnExit];
    AProcess.Execute;
  finally
    AProcess.Free;
  end;


end;

procedure TForm1.Button1Click(Sender: TObject);
begin

PlaySound('kickdrum.wav');

if not Timer1.Enabled then
    begin
      Timer1.Enabled := True; // Start the timer
      Increasing := Self.Height <= 47; // Determine the direction based on current height
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Increasing:=TRue;
end;




end.

