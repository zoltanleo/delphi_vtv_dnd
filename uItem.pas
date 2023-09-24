unit uItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VirtualTrees, Vcl.StdCtrls, Vcl.ExtCtrls, MemTableDataEh, Data.DB, MemTableEh,
  System.Actions, Vcl.ActnList
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
    actList: TActionList;
    actChoice: TAction;
    actCancel: TAction;
    procedure FormCreate(Sender: TObject);
    procedure PriceTreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure PriceTreeGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
    procedure PriceTreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType; var CellText: string);
    procedure FormPaint(Sender: TObject);
    procedure actChoiceExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure PriceTreeDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmItem: TfrmItem;

implementation

{$R *.dfm}

procedure TfrmItem.actCancelExecute(Sender: TObject);
begin
  Self.ModalResult:= mrCancel;
end;

procedure TfrmItem.actChoiceExecute(Sender: TObject);
begin
  if ((PriceTree.RootNodeCount = 0) or (PriceTree.SelectedCount <> 1)) then Exit;
  Self.ModalResult:= mrOk;
end;

procedure TfrmItem.FormCreate(Sender: TObject);
const
  EmptyContent = 'Список возможного выбора пуст!';
begin
  Self.ModalResult:= mrCancel;
  actChoice.SecondaryShortCuts.Add('Enter');
  actChoice.SecondaryShortCuts.Add('Enter+Ctrl');
  actCancel.SecondaryShortCuts.Add('Esc');

  with lblEmptyWarninig do
  begin
    Parent:= PriceTree;
    Caption:= EmptyContent;
    Font.Color:= clRed;
    Visible:= False;
  end;

  with mds_items do
  begin
    FieldDefs.Add('BASEPRICE_ID', ftInteger);
    FieldDefs.Add('BASEPRICE_PROC_CODE', ftString, 20);
    FieldDefs.Add('BASEPRICE_PROC_NAME', ftString, 100);
    FieldDefs.Add('BASEPRICE_PROC_ISSUE_FK', ftInteger);

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

  with PriceTree do
  begin
    TreeOptions.SelectionOptions:= TreeOptions.SelectionOptions
              + [toExtendedFocus, toFullRowSelect, toAlwaysSelectNode]
              - []
              ;

    TreeOptions.PaintOptions:= TreeOptions.PaintOptions
              + [toShowHorzGridLines]
              - [toShowTreeLines]
              ;

    with Header do
    begin
      Columns.Add;
      MainColumn:= 0;
      Options:= Options + [hoAutoResize];
    end;
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

procedure TfrmItem.PriceTreeDblClick(Sender: TObject);
begin
  actChoiceExecute(Sender);
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
