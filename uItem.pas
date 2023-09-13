unit uItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VirtualTrees, Vcl.StdCtrls, Vcl.ExtCtrls, MemTableDataEh, Data.DB, MemTableEh
//  , Unit1
  ;

type
  PTreeItem = ^TTreeItem;
  TTreeItem = record
    ItemID: Integer;
    ItemName: string;
    ItemLiter: string;
  end;

  TfrmItem = class(TForm)
    pnlTree: TPanel;
    pnlBtns: TPanel;
    btnSave: TButton;
    btnCancel: TButton;
    PriceTree: TVirtualStringTree;
    mds_items: TMemTableEh;
    mds_issue: TMemTableEh;
    lblEmptyWarninig: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure PriceTreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure PriceTreeGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
    procedure PriceTreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType; var CellText: string);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmItem: TfrmItem;

implementation

{$R *.dfm}

procedure TfrmItem.btnCancelClick(Sender: TObject);
begin
  Self.ModalResult:= mrCancel;
end;

procedure TfrmItem.btnSaveClick(Sender: TObject);
begin
  Self.ModalResult:= mrOk;
end;

procedure TfrmItem.FormCreate(Sender: TObject);
const
  EmptyContent = 'Список возможного выбора пуст!';
begin
  Self.ModalResult:= mrCancel;


  with lblEmptyWarninig do
  begin
    Parent:= PriceTree;
//    Top:= Parent.Top + Parent.Height div 3;
//    Left:= (Parent.ClientWidth - Canvas.TextWidth(lblEmptyWarninig.Caption)) div 2;
    Caption:= EmptyContent;
    Font.Color:= clRed;
    Visible:= False;
  end;

  with mds_items do
  begin
    FieldDefs.Add('LABORISSUE_ID', ftInteger);
    FieldDefs.Add('LABORISSUE_NAME', ftString, 100);
    FieldDefs.Add('LABORISSUE_CODELITER', ftString, 5);
    FieldDefs.Add('BASEPRICE_ID', ftInteger);
    FieldDefs.Add('BASEPRICE_PROC_NAME', ftString, 100);

    CreateDataSet;
    Filtered:= False;
    Active := False;
  end;

  with mds_issue do
  begin
    FieldDefs.Add('LABORISSUE_ID', ftInteger);
    FieldDefs.Add('LABORISSUE_NAME', ftString, 100);
    FieldDefs.Add('LABORISSUE_CODELITER', ftString, 5);

    CreateDataSet;
    Filtered:= False;
    Active := False;
  end;

  with PriceTree.Header do
  begin
    Columns.Add;
    MainColumn:= 0;
    Options:= Options + [hoAutoResize];
  end;
end;

procedure TfrmItem.FormPaint(Sender: TObject);
begin
  if lblEmptyWarninig.Visible then
  begin
    lblEmptyWarninig.Top:= PriceTree.Top + PriceTree.Height div 3;
    lblEmptyWarninig.Left:= (PriceTree.Width - Canvas.TextWidth(lblEmptyWarninig.Caption)) div 2;
  end;
end;

procedure TfrmItem.PriceTreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Data: PTreeItem;
begin
  Data:= Sender.GetNodeData(Node);
  if Assigned(Data) then Finalize(Data^);
end;

procedure TfrmItem.PriceTreeGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
begin
  NodeDataSize:= SizeOf(TTreeItem);
end;

procedure TfrmItem.PriceTreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: string);
var
  Data: PTreeItem;
begin
  Data:= nil;
  Data:= Sender.GetNodeData(Node);
  if not Assigned(Data) then Exit;

  case Column of
    0: CellText:= Data.ItemName;
  end;

end;

end.
