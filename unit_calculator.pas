unit unit_calculator;

{$mode objfpc}{$H+}


interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, unit_ref;

type

  { TformMain }

  TformMain = class(TForm)
    Button1: TButton;
    Button10: TButton;
    ButtonDot: TButton;
    Button_change: TButton;
    Button_power: TButton;
    Button_clear: TButton;
    Button_add: TButton;
    Button_del: TButton;
    Button_inverse: TButton;
    Button_sqrt: TButton;
    Button_sub: TButton;
    Button_mult: TButton;
    Button_div: TButton;
    Button_result: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button_dotClick(Sender: TObject);
    procedure Button_numberClick(Sender: TObject);
    procedure Button_changeClick(Sender: TObject);
    procedure Button_clearClick(Sender: TObject);
    procedure Button_delClick(Sender: TObject);
    procedure Button_BaseOperationClick(Sender: TObject);
    procedure Button_extraClick(Sender: TObject);
    procedure Button_resultClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private

  public
    one: Double;
    two: Double;
    operation: String;
    calculation: Boolean;
    field: String;

  end;

var
  formMain: TformMain;

implementation

uses LCLType;

{$R *.lfm}

{ TformMain }

procedure TformMain.FormShow(Sender: TObject);
begin
  Label1.Caption:='0';
  Label2.Caption:='';
  one:=0;
  two:=0;
  operation:='';
  calculation:=False;
  field:='';
end;

procedure TformMain.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if ( Key = VK_F1 ) then
    begin
      formRef := TformRef.Create(Application);
      formRef.ShowModal;
    end;
end;

procedure TformMain.Button_numberClick(Sender: TObject);
begin
  if pos('=', Label2.Caption) <> 0 then Label2.Caption:='';
  if (Length(Label1.Caption)>=16) and (Label1.Caption<>'Нельзя делить на 0') then exit;
  if (Label1.Caption='0') or (Label1.Caption='Нельзя делить на 0') then
    Label1.Caption:=(Sender as TButton).Caption
  else
    Label1.Caption:=Label1.Caption+(Sender as TButton).Caption;
end;

procedure TformMain.Button_dotClick(Sender: TObject);
begin
  if Label1.Caption <> 'Нельзя делить на 0' then
     if pos(',', Label1.Caption) = 0 then
       Label1.Caption:=Label1.Caption+',';
end;

procedure TformMain.Button_BaseOperationClick(Sender: TObject);
begin
  if Label1.Caption <> 'Нельзя делить на 0' then
    begin
      calculation:=True;
      operation:=(Sender as TButton).Caption;
      field := Label1.Caption;
      if field[length(field)] = ',' then delete(field, length(field), 1);
      one:=StrToFloat(field);
      Label2.Caption:=field+operation;
      Label1.Caption:='0';
      field:='';
    end;
end;

procedure TformMain.Button_resultClick(Sender: TObject);
begin
  if (calculation = True) and (Label1.Caption <> 'Нельзя делить на 0') then
    begin
      field:=Label1.Caption;
      if field[length(field)] = ',' then delete(field, length(field), 1);
      two:=StrToFloat(field);
      Label2.Caption:=Label2.Caption+field+'=';
      if operation = '+' then one := one + two;
      if operation = '-' then one := one - two;
      if operation = '×' then one := one * two;
      if operation = '÷' then
        begin
          if two = 0 then Label1.Caption:='Нельзя делить на 0'
          else
            begin
              one := one / two;
              two := 0;
            end;
        end;
      if Label1.Caption <> 'Нельзя делить на 0' then Label1.Caption:=FloatToStr(one);
      field:='';
      calculation:=False;
    end;
end;


procedure TformMain.Button_extraClick(Sender: TObject);
begin
  if Label1.Caption <> 'Нельзя делить на 0' then
    begin
      field := Label1.Caption;
      if field[length(field)] = ',' then delete(field, length(field), 1);
      one:=StrToFloat(field);
      if (Sender as TButton).Caption = '√x' then
        begin
          Label2.Caption:='√'+field+'=';
          one:=sqrt(one);
        end;
      if (Sender as TButton).Caption = 'x²' then
        begin
          Label2.Caption:=field+'²'+'=';
          one:=one*one;
        end;
      if (Sender as TButton).Caption = '1/x' then
        begin
          Label2.Caption:='1/'+field+'=';
          if one = 0 then Label1.Caption:='Нельзя делить на 0'
          else one:=1/one;
        end;
      if Label1.Caption <> 'Нельзя делить на 0' then Label1.Caption:=FloatToStr(one);
      field:='';
    end;
end;

procedure TformMain.Button_changeClick(Sender: TObject);
begin
  if Label1.Caption <> 'Нельзя делить на 0' then
    begin
     field:=Label1.Caption;
     if field[1] <> '-' then field:='-'+field
     else delete(field, 1, 1);
     Label1.Caption:=field;
     field:=''
    end;
end;

procedure TformMain.Button_clearClick(Sender: TObject);
begin
   Label1.Caption:='0';
   Label2.Caption:='';
   one:=0;
   two:=0;
   operation:='';
   calculation:=False;
   field:='';
end;

procedure TformMain.Button_delClick(Sender: TObject);
begin
   field:=Label1.Caption;
   if (Length(field) = 1) or ((Length(field) = 2) and (field[1] = '-')) or (field = 'Нельзя делить на 0') then
     field:='0'
   else
      delete(field, length(Label1.Caption), 1);
   Label1.Caption:=field;
   Label2.Caption:='';
   field:='';
end;


end.

