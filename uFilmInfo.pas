unit uFilmInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  Tr = class(TFrame)
    LabeledEdit1: TLabeledEdit;
    MaskEdit1: TMaskEdit;
    LabeledEdit2: TLabeledEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
