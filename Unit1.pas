unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, MemTableDataEh, Data.DB, MemTableEh, DBGridEhGrouping,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, FIBQuery, pFIBQuery, FIBDatabase, pFIBDatabase, EhLibVCL, GridsEh,
  DBAxisGridsEh, DBGridEh, fib, Vcl.ComCtrls, VirtualTrees, Vcl.ExtCtrls, System.Actions, Vcl.ActnList
  , Winapi.ActiveX, Vcl.Samples.Spin, Vcl.Menus
  ;

type
  TTreeChangeType = (tctNone, tctDeleted, tctInserted, tctUpdated);
  TEditMode = (emAdd, emEdit);
  TActionNodeSender = (ansNodeRoot, ansNodeChild, ansNodeEdit);

  PMyRec = ^TMyRec;
  TMyRec = record
    PriceID: Integer;
    DepartID: Integer;
    CurrentChangeType: TTreeChangeType;
    LastChangeType: TTreeChangeType;
    PriceName: string;
    CurrentCost: Currency;
    LastCost: Currency;
  end;

  TForm1 = class(TForm)
    tmpDB: TpFIBDatabase;
    tmpTrans: TpFIBTransaction;
    tmpQry: TpFIBQuery;
    ds_price: TDataSource;
    mds_price: TMemTableEh;
    actList: TActionList;
    actPriceFill: TAction;
    actPriceDel: TAction;
    mds_labor: TMemTableEh;
    mds_src: TMemTableEh;
    pnlTblPrice: TPanel;
    DBGridEh1: TDBGridEh;
    Panel3: TPanel;
    ActRootAdd: TAction;
    ActChildAdd: TAction;
    ActNodeEdt: TAction;
    ActNodeDel: TAction;
    pnlPrices: TPanel;
    cbbPrice: TComboBox;
    btnPriceAdd: TButton;
    btnPriceDel: TButton;
    pnlEdtNodeData: TPanel;
    ActNodeDataSave: TAction;
    ActNodeDataCancel: TAction;
    ActChkStatusBtn: TAction;
    actEdtNodeDataOn: TAction;
    actEdtNodeDataOff: TAction;
    pnlTreeView: TPanel;
    vst: TVirtualStringTree;
    btnRootAdd: TButton;
    btnChildAdd: TButton;
    btnNodeEdt: TButton;
    btnNodeDel: TButton;
    pnlItemEdt: TPanel;
    Button2: TButton;
    Button3: TButton;
    pnlEdtCost: TPanel;
    edtPriceCost: TEdit;
    udPriceCost: TUpDown;
    pnlPriceNameEdt: TPanel;
    edtPriceName: TEdit;
    btnNodeRestore: TButton;
    ActNodeRestore: TAction;
    ppmVST: TPopupMenu;
    actAllExpand: TAction;
    actAllCollaps: TAction;
    actNodeCollaps: TAction;
    actNodeExpand: TAction;
    ActChkStatusMnuVST: TAction;
    N1: TMenuItem;
    Expandallnodes1: TMenuItem;
    Collapsallnodes1: TMenuItem;
    Expandrootnode1: TMenuItem;
    Collapsrootnode1: TMenuItem;
    N2: TMenuItem;
    AddRoot1: TMenuItem;
    AddChild1: TMenuItem;
    NodeEdit1: TMenuItem;
    N3: TMenuItem;
    NodeDel1: TMenuItem;
    NodeRestore1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbbPriceChange(Sender: TObject);
    procedure vstGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
    procedure vstFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vstGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: string);
    procedure actPriceFillExecute(Sender: TObject);
    procedure vstNewText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; NewText: string);
    procedure vstEditing(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
    procedure vstKeyPress(Sender: TObject; var Key: Char);
    procedure ActRootAddExecute(Sender: TObject);
    procedure ActChildAddExecute(Sender: TObject);
    procedure ActNodeEdtExecute(Sender: TObject);
    procedure vstDragOver(Sender: TBaseVirtualTree; Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint;
      Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
    procedure vstDragDrop(Sender: TBaseVirtualTree; Source: TObject; DataObject: IDataObject; Formats: TFormatArray;
      Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
    procedure vstAddToSelection(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vstNodeClick(Sender: TBaseVirtualTree; const HitInfo: THitInfo);
    procedure ActNodeDelExecute(Sender: TObject);
    procedure edtPriceCostChange(Sender: TObject);
    procedure edtPriceCostKeyPress(Sender: TObject; var Key: Char);
    procedure ActNodeDataSaveExecute(Sender: TObject);
    procedure ActNodeDataCancelExecute(Sender: TObject);
    procedure ActChkStatusBtnExecute(Sender: TObject);
    procedure actEdtNodeDataOffExecute(Sender: TObject);
    procedure actEdtNodeDataOnExecute(Sender: TObject);
    procedure vstInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode;
      var InitialStates: TVirtualNodeInitStates);
    procedure ActNodeRestoreExecute(Sender: TObject);
    procedure vstPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure vstRemoveFromSelection(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActChkStatusBtnUpdate(Sender: TObject);
    procedure actAllExpandExecute(Sender: TObject);
    procedure actAllCollapsExecute(Sender: TObject);
    procedure actNodeCollapsExecute(Sender: TObject);
    procedure actNodeExpandExecute(Sender: TObject);
    procedure ActChkStatusMnuVSTExecute(Sender: TObject);
    procedure vstCollapsed(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vstExpanded(Sender: TBaseVirtualTree; Node: PVirtualNode);
  private
    FClinicID: Integer;
    FPeolpeID: Integer;
    FDoctorID: Integer;
    FPriceName: string;
    FFilterStr: string;
    FTreeChangeType: TTreeChangeType;
    FEditMode: TEditMode;
    FActionNodeSender: TActionNodeSender;
    FNodeSender: PVirtualNode;
    procedure FillCbbPrice(Sender: TObject);
  public
    property ClinicID: Integer read FClinicID;
    property PeolpeID: Integer read FPeolpeID;
    property DoctorID: Integer read FDoctorID;
    property PriceName: string read FPriceName write FPriceName;
    property FilterStr: string read FFilterStr;
    property TreeChangeType: TTreeChangeType read FTreeChangeType;
    property NodeSender: PVirtualNode read FNodeSender;
    property ActionNodeSender: TActionNodeSender read FActionNodeSender;
    property EditMode: TEditMode read FEditMode write FEditMode;
  end;

const
  libname = 'c:\firebird\fb_3_0_10_x32\fbclient.dll';
  connstr = '127.0.0.1/31064:c:\proj\test_delphi\delphi_vtv_dnd\base\Price.fdb';
  usrname = 'user_name=SYSDBA';
  pwd = 'password=cooladmin';
  chrset = 'lc_ctype=WIN1251';
  repPath = 'c:\proj\test_delphi\db_test\reports\';
  cPriceName = 'Прайс Биомед 01.03.2022';
  RepDSFilter = '(LABORISSUE_ID=2) OR (LABORISSUE_ID=3)';

  SQLTextTblPriceSelect =
    'SELECT ' +
      'MAX(ID_PRICE) AS ID_PRICE, ' +
      'NAME_PRICE ' +
    'FROM TBL_PRICE ' +
    'GROUP BY NAME_PRICE ' +
    'ORDER BY 1 DESC';

  SQLTextTblIssueSelect =
    'SELECT ' +
        'LABORISSUE_ID, ' +
        'LABORISSUE_NAME ' +
    'FROM TBL_LABORISSUE ' +
    'ORDER BY 1';

    SQLTextRep =
      'SELECT ' +
          'BP.BASEPRICE_ID, ' +
          'BP.BASEPRICE_PROC_NAME, ' +
          'P.COST_PROC_PRICE, ' +
          'LI.LABORISSUE_ID, ' +
          'LI.LABORISSUE_NAME, ' +
          'P.NAME_PRICE ' +
      'FROM TBL_LABORISSUE LI ' +
         'JOIN TBL_BASEPRICE BP ON (LI.LABORISSUE_ID = BP.BASEPRICE_PROC_ISSUE_FK) ' +
         'JOIN TBL_PRICE P ON (BP.BASEPRICE_ID = P.FK_BASEPRICE) ' +
//      'WHERE (P.COST_PROC_PRICE > 0)  ' +
//              'AND (NAME_PRICE CONTAINING :NAME_PRICE) ' +
      'ORDER BY 1';

{$REGION 'report SQLText'}
    SQLTextClinicList =
          'SELECT ' +
            'ID_CLINIC, CLIN_NAME, CLIN_ADRESS, CLIN_ADRESSBOOL, ' +
            'CLIN_PHONE, CLIN_REKVIZIT, CLIN_LOGOS, CLIN_LOGOS_EXT, ' +
            'CLIN_LOGOSBOOL, CLIN_INTERNET, CLIN_LICENSE, CLIN_LICENSEBOOL, CLIN_NALOG ' +
          'FROM TBL_CLINIC ' +
          'ORDER BY 1';
  
    SQLTextDoctorList =
          'SELECT ' +
            'ID_DOCTOR, DOC_LASTNAME ' +
          'FROM TBL_DOCTOR ' +
          'ORDER BY 1';
  
    SQLTextInfo =
          'SELECT ' +
              'ID_ANKETA, ' +
              'TRIM(' +
              'TRIM(ANKLASTNAME)||'' ''||' +
              'TRIM(ANKFIRSTNAME)||'' ''||' +
              'TRIM(ANKTHIRDNAME)||'', ''||' +
              'IIF(EXTRACT(DAY FROM ANKDATEBORN) < 10,''0''||CAST(EXTRACT(DAY FROM ANKDATEBORN) ' +
                'AS VARCHAR(1)),CAST(EXTRACT(DAY FROM ANKDATEBORN) AS VARCHAR(2)))' +
              '||''.''||' +
              'IIF(EXTRACT(MONTH FROM ANKDATEBORN) < 10,''0''||CAST(EXTRACT(MONTH FROM ANKDATEBORN) ' +
                'AS VARCHAR(1)),CAST(EXTRACT(MONTH FROM ANKDATEBORN) AS VARCHAR(2)))' +
              '||''.''||' +
              'CAST(EXTRACT(YEAR FROM ANKDATEBORN) AS VARCHAR(4))' +
              '||''г.р.''||' +
              'COALESCE('' (кон.тел. ''||TRIM(ANKPHONE)||'')'','''')' +
              ') AS FULL_PATINFO, ' + //*varchar(130)*/
              'SEX, ' +
              'UPPER(ANKLASTNAME||'' ''||ANKFIRSTNAME||'' ''||COALESCE(ANKTHIRDNAME,'''')) AS FULL_FIO, ' +
              'UPPER(ANKLASTNAME||''_''||SUBSTRING(ANKFIRSTNAME FROM 1 FOR 1)||SUBSTRING(COALESCE(ANKTHIRDNAME,'''') FROM 1 FOR 1))||' +
              '''_''||EXTRACT(YEAR FROM ANKDATEBORN)||''__''||CURRENT_DATE AS EXPORT_FN, ' +
              'ID_CLINIC, ' +
              'CLIN_NAME, ' + //*varchar(100)*/
              'CAST(COALESCE(CLIN_ADRESS,CLIN_ADRESS,'''') AS VARCHAR(500)) AS CLIN_ADRESS, ' +//*varchar(500)*/
              'COALESCE(CLIN_PHONE,CLIN_PHONE,'''') AS CLIN_PHONE, ' + //*varchar(100)*/
              'CLIN_LOGOS, ' +
              'CAST(COALESCE(CLIN_LICENSE,CLIN_LICENSE,'''') AS VARCHAR(500)) AS CLIN_LICENSE, ' + //*varchar(500)*/
              'ID_DOCTOR, ' +
              'TRIM(' +
              'TRIM(CASE DOC_STEPEN ' +
                     'WHEN 0 THEN '''' ' +
                     'WHEN 1 THEN ''к.м.н.,'' ' +
                     'WHEN 2 THEN ''д.м.н.,'' ' +
                   'END)||'' ''||' +
              'TRIM(CASE DOC_CATEGORY ' +
                     'WHEN 0 THEN ''врач'' ' +
                     'WHEN 1 THEN ''врач 2-й кат.,'' ' +
                     'WHEN 2 THEN ''врач 1-й кат.,'' ' +
                     'WHEN 3 THEN ''врач высш.кат.,'' ' +
              'END)||'' ''||' +
              'TRIM(DOC_PROFIL)||'' ''||' +
              'DOC_LASTNAME||'' ''||' +
              'UPPER(LEFT(DOC_FIRSTNAME, 1))||''.''||' +
              'UPPER(LEFT(DOC_THIRDNAME, 1))||''.''||' +
              'CASE DOC_PHONENUMBACCESS ' +
                 'WHEN 1 THEN COALESCE('' (кон.тел. ''||DOC_CONTACTPHONE||'')'','''') ' +
                 'ELSE '''' ' +
              'END) AS FULL_DOCINFO ' + //*varchar(220)*/
          'FROM TBL_ANKETA, TBL_CLINIC, TBL_DOCTOR ' +
          'WHERE (ID_ANKETA = :ID_ANKETA) AND (ID_CLINIC = :ID_CLINIC) ' +
                 'AND (ID_DOCTOR = :ID_DOCTOR)';
  
    SQLTextPeople =
    'SELECT ID_ANKETA, ANKLASTNAME, ANKFIRSTNAME, ANKTHIRDNAME ' +
      ', SEX, ANKDATEBORN, ANKADRESS, ANKPHONE, SOCIAL ' +
    'FROM TBL_ANKETA ' +
    'WHERE ID_ANKETA < 500 ' +
    'ORDER BY 1';
{$ENDREGION}

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.ActRootAddExecute(Sender: TObject);
var
  NodeLvl: Integer;
begin
  actEdtNodeDataOnExecute(Sender);
  pnlEdtCost.Visible:= False;
  edtPriceName.Clear;

  FActionNodeSender:= ansNodeRoot;

  if (vst.SelectedCount > 0)
    then FNodeSender:= vst.GetFirstSelected
    else FNodeSender:= nil;

  FTreeChangeType:= tctInserted;
  if edtPriceName.CanFocus then edtPriceName.SetFocus;
end;

procedure TForm1.ActChkStatusBtnExecute(Sender: TObject);
var
  NodeLvl: Integer;
  Node: PVirtualNode;
  Nodes: TNodeArray;
  Data: PMyRec;
  I: Integer;
begin
  if (csDestroying in ComponentState) then Exit;

  ActNodeEdt.Enabled:= False;
//  ActChildAdd.Enabled:= ((vst.RootNodeCount > 0) and (vst.SelectedCount = 1));
  ActChildAdd.Enabled:= False;

  case vst.SelectedCount of
    0:
      begin
        ActNodeDel.Enabled:= False;
        ActNodeRestore.Enabled:= False;
      end;
    1:
      begin
        Data:= vst.GetNodeData(vst.GetFirstSelected);

        if Assigned(Data) then
        begin
          ActNodeDel.Enabled:= (Data^.CurrentChangeType <> tctDeleted);
          ActNodeRestore.Enabled:= (Data^.CurrentChangeType = tctDeleted);
          ActNodeEdt.Enabled:= (Data^.CurrentChangeType <> tctDeleted);

          NodeLvl:= vst.GetNodeLevel(vst.GetFirstSelected);

          if (NodeLvl = 1) then Data:= vst.GetNodeData(vst.GetFirstSelected.Parent);
          ActChildAdd.Enabled:= ((vst.RootNodeCount > 0) and (Data^.CurrentChangeType <> tctDeleted));
        end;
      end;
    else
      begin
        ActNodeDel.Enabled:= True;
        ActNodeRestore.Enabled:= True;

        Nodes:= vst.GetSortedSelection(True);

        for i := 0 to Pred(System.Length(Nodes)) do
        begin
          Data:= vst.GetNodeData(Nodes[i]);
          if Assigned(Data) then
            if (Data^.CurrentChangeType = tctDeleted) then
            begin
              ActNodeDel.Enabled:= False;
              Break;
            end;
        end;

        for i := 0 to Pred(System.Length(Nodes)) do
        begin
          Data:= vst.GetNodeData(Nodes[i]);
          if Assigned(Data) then
            if (Data^.CurrentChangeType <> tctDeleted) then
            begin
              ActNodeRestore.Enabled:= False;
              Break;
            end;
        end;
      end;
  end;

  btnChildAdd.Enabled:= ActChildAdd.Enabled;
  btnNodeEdt.Enabled:= ActNodeEdt.Enabled;
  btnNodeDel.Enabled:= ActNodeDel.Enabled;
  btnNodeRestore.Enabled:= ActNodeRestore.Enabled;
end;

procedure TForm1.ActChkStatusBtnUpdate(Sender: TObject);
var
  NodeLvl: Integer;
  Node: PVirtualNode;
  Nodes: TNodeArray;
  Data: PMyRec;
  I: Integer;
begin
  Exit;
  ActNodeEdt.Enabled:= (vst.SelectedCount = 1);
  btnNodeEdt.Enabled:= ActNodeEdt.Enabled;

  ActChildAdd.Enabled:= ((vst.RootNodeCount > 0) and (vst.SelectedCount = 1));
  btnChildAdd.Enabled:= ActChildAdd.Enabled;

  case vst.SelectedCount of
    0:
      begin
        ActNodeDel.Enabled:= False;
        ActNodeRestore.Enabled:= False;
      end;
    1:
      begin
        Data:= vst.GetNodeData(vst.GetFirstSelected);

        if Assigned(Data) then
        begin
          ActNodeDel.Enabled:= (Data^.CurrentChangeType <> tctDeleted);
          ActNodeRestore.Enabled:= (Data^.CurrentChangeType = tctDeleted);
        end;
      end;
    else
      begin
        ActNodeDel.Enabled:= True;
        ActNodeRestore.Enabled:= True;

        Nodes:= vst.GetSortedSelection(True);

        for i := 0 to Pred(System.Length(Nodes)) do
        begin
          Data:= vst.GetNodeData(Nodes[i]);
          if Assigned(Data) then
            if (Data^.CurrentChangeType = tctDeleted) then
            begin
              ActNodeDel.Enabled:= False;
              Break;
            end;
        end;

        for i := 0 to Pred(System.Length(Nodes)) do
        begin
          Data:= vst.GetNodeData(Nodes[i]);
          if Assigned(Data) then
            if (Data^.CurrentChangeType <> tctDeleted) then
            begin
              ActNodeRestore.Enabled:= False;
              Break;
            end;
        end;

      end;
  end;

  btnNodeDel.Enabled:= ActNodeDel.Enabled;
  btnNodeRestore.Enabled:= ActNodeRestore.Enabled;
end;

procedure TForm1.ActChkStatusMnuVSTExecute(Sender: TObject);
var
  Node: PVirtualNode;
  NodeLvl: Integer;
begin
  Node:= vst.GetFirstSelected(True);

  if not Assigned(node) then Exit;
  NodeLvl:= vst.GetNodeLevel(Node);

  if (NodeLvl > 0) then Node:= Node.Parent;

  actNodeCollaps.Enabled:= ((vst.SelectedCount = 1) and (vsExpanded in Node^.States));
  actNodeExpand.Enabled:= ((vst.SelectedCount = 1) and not (vsExpanded in Node^.States));
end;

procedure TForm1.actEdtNodeDataOffExecute(Sender: TObject);
var
  i: Integer;
  EditMode: Boolean;
begin
  vst.BeginUpdate;
  try
    vst.Refresh;
    EditMode:= False;

    for I := 0 to  Pred(pnlTreeView.ControlCount) do
    begin
      if TObject(pnlTreeView.Controls[i]).InheritsFrom(TButton) then
        TButton(pnlTreeView.Controls[i]).Enabled:= not EditMode;
    end;

    vst.Enabled:= not EditMode;
    pnlEdtNodeData.Visible:= EditMode;

    ActRootAdd.Enabled:= not EditMode;
    ActChildAdd.Enabled:= not EditMode;
    ActNodeEdt.Enabled:= not EditMode;
    ActNodeDel.Enabled:= not EditMode;
  finally
    vst.EndUpdate;
    ActChkStatusBtnExecute(Sender);
  end;
end;

procedure TForm1.actEdtNodeDataOnExecute(Sender: TObject);
var
  i: Integer;
  EditMode: Boolean;
begin
  EditMode:= True;

  for I := 0 to  Pred(Panel3.ControlCount) do
  begin
    if TObject(Panel3.Controls[i]).InheritsFrom(TButton) then
      TButton(Panel3.Controls[i]).Enabled:= not EditMode;
  end;

  vst.Enabled:= not EditMode;
  pnlEdtNodeData.Visible:= EditMode;

  ActRootAdd.Enabled:= not EditMode;
  ActChildAdd.Enabled:= not EditMode;
  ActNodeEdt.Enabled:= not EditMode;
  ActNodeDel.Enabled:= not EditMode;
end;

procedure TForm1.actNodeCollapsExecute(Sender: TObject);
var
  NodeLvl: Integer;
  Node: PVirtualNode;
begin
  if (vst.SelectedCount <> 1) then Exit;

  Node:= vst.GetFirstSelected;
  if not Assigned(Node) then Exit;
  NodeLvl:= vst.GetNodeLevel(Node);

  if (NodeLvl <> 0) then Node:= Node.Parent;
  vst.Expanded[Node]:= False;
end;

procedure TForm1.ActNodeDataCancelExecute(Sender: TObject);
begin
  actEdtNodeDataOffExecute(Sender);
end;

procedure TForm1.ActNodeDataSaveExecute(Sender: TObject);
var
  NodeLvl: Integer;
  Node: PVirtualNode;
  Data: PMyRec;
//  bb: Boolean;
//  ss: string;
//  aa: Integer;
  tmpCurr: Currency;
  fs: TFormatSettings;
begin
  if (Trim(edtPriceName.Text) = '') then
  begin
    Application.MessageBox('Поле не может быть пустым!','Некорректные данные',MB_ICONINFORMATION);
    if edtPriceName.CanFocus then edtPriceName.SetFocus;
    Exit;
  end;

//  bb:= False;
//  bb:= mds_labor.Locate('LABORISSUE_NAME',Trim(edtPriceName.Text),[loCaseInsensitive]);
//  ss:= UpperCase(mds_labor.FieldByName('LABORISSUE_NAME').AsString,loUserLocale);//worked
//  ss:= UpperCase(mds_labor.FieldByName('LABORISSUE_NAME').AsString,loInvariantLocale);//not worked
//  ss:= UpperCase(Trim(edtPriceName.Text), loUserLocale);//worked
//  aa:= CompareText(mds_labor.FieldByName('LABORISSUE_NAME').AsString,Trim(edtPriceName.Text));// <> 0 --> not worked
//  aa:= CompareText(mds_labor.FieldByName('LABORISSUE_NAME').AsString,Trim(edtPriceName.Text), loUserLocale); = 0 --> worked

  if mds_labor.Locate('LABORISSUE_NAME',Trim(edtPriceName.Text),[loCaseInsensitive]) then
    if (CompareText(mds_labor.FieldByName('LABORISSUE_NAME').AsString,Trim(edtPriceName.Text), loUserLocale) = 0) then
    begin
      Application.MessageBox('В базе данных уже есть раздел с таким названием!','Некорректные данные',MB_ICONINFORMATION);
      if edtPriceName.CanFocus then edtPriceName.SetFocus;
      Exit
    end;

  case ActionNodeSender of
    ansNodeRoot:
              begin
                if not Assigned(NodeSender)
                  then Node:= vst.AddChild(NodeSender)
                  else
                    begin
                      NodeLvl:= vst.GetNodeLevel(NodeSender);
                      if (NodeLvl = 1) then FNodeSender:= NodeSender.Parent;
                      Node:= vst.InsertNode(NodeSender, amInsertAfter);
                    end;
              end;
    ansNodeChild:
              begin
                if not Assigned(NodeSender) then Exit;
                NodeLvl:= vst.GetNodeLevel(NodeSender);

                case NodeLvl of
                  0: Node:= vst.InsertNode(NodeSender, amAddChildFirst);
                  1: Node:= vst.InsertNode(NodeSender, amInsertAfter);
                end;
              end;
    ansNodeEdit: Node:= NodeSender;
  end;

  Data:= vst.GetNodeData(Node);
  if Assigned(Data) then
  begin
    NodeLvl:= vst.GetNodeLevel(Node);

    Data.PriceID:= vst.AbsoluteIndex(Node);
    Data.DepartID:= 0;
    Data.PriceName:= Trim(edtPriceName.Text);

    case EditMode of
      emAdd:
        begin
          Data.CurrentChangeType:= tctInserted;
          Data.LastChangeType:= tctInserted;
        end;
      emEdit:
        case ActionNodeSender of
          ansNodeEdit:
            begin
              if (Data.LastChangeType = tctNone) then Data.CurrentChangeType:= tctUpdated;
              Data.LastChangeType:= tctNone;
            end;
          else
            begin
              Data.CurrentChangeType:= tctInserted;
              Data.LastChangeType:= tctInserted;
            end;

        end;
    end;

    Data.CurrentCost:= 0;
    Data.LastCost:= 0;

    if (NodeLvl = 1) then
    begin
      fs:= TFormatSettings.Create;
      if TryStrToCurr(edtPriceCost.Text, tmpCurr,fs) then
      begin
        Data.CurrentCost:= tmpCurr;
        Data.LastCost:= tmpCurr;
      end;
    end;
  end;

  vst.Refresh;
  actEdtNodeDataOffExecute(Sender);
  vst.ClearSelection;
  vst.ScrollIntoView(Node,True,False);
  vst.Selected[Node]:= True;
  if vst.CanFocus then vst.SetFocus;

  ActChkStatusBtnExecute(Sender);
end;

procedure TForm1.ActNodeDelExecute(Sender: TObject);
var
  Nodes: TNodeArray;
  Data: PMyRec;
  i: Integer;
  chNode: PVirtualNode;
  Nodelvl: Integer;
begin
  if (vst.SelectedCount = 0) then Exit;

  Nodes:= vst.GetSortedSelection(True);

  for i := 0 to Pred(System.Length(Nodes)) do
  begin
    if (vst.GetNodeLevel(Nodes[i]) = 0)
    then
      begin
        Data:= vst.GetNodeData(Nodes[i]);

        if Assigned(Data) then
        begin
          Data^.LastChangeType:= Data^.CurrentChangeType;
          Data^.CurrentChangeType:= tctDeleted;

          if (vsHasChildren in Nodes[i]^.States) then
          begin
            chNode:=  Nodes[i]^.FirstChild;

            while Assigned(chNode) do
            begin
              Data:= vst.GetNodeData(chNode);

              if Assigned(Data) then
              begin
                Data^.LastChangeType:= Data^.CurrentChangeType;
                Data^.CurrentChangeType:= tctDeleted;
                chNode:= chNode.NextSibling;
              end;
            end;
          end;
        end;
      end
    else
      begin
        Data:= vst.GetNodeData(Nodes[i]);
        if Assigned(Data) then
        begin
          Data^.LastChangeType:= Data^.CurrentChangeType;
          Data^.CurrentChangeType:= tctDeleted;
        end;
      end;
  end;

  vst.Refresh;
  if vst.CanFocus then vst.SetFocus;

  ActChkStatusBtnExecute(Sender);
end;

procedure TForm1.ActNodeEdtExecute(Sender: TObject);
var
  tmpCurr: Currency;
  fs: TFormatSettings;
  Data: PMyRec;
  NodeLvl: Integer;
begin
  if (vst.SelectedCount <> 1) then Exit;

  FNodeSender:= vst.GetFirstSelected;
  if not Assigned(NodeSender) then Exit;

  FActionNodeSender:= ansNodeEdit;
  NodeLvl:= vst.GetNodeLevel(NodeSender);
  pnlEdtCost.Visible:= (NodeLvl = 1);

  Data:= vst.GetNodeData(NodeSender);
  if not Assigned(Data) then Exit;

  actEdtNodeDataOnExecute(Sender);
  edtPriceName.Text:= Data^.PriceName;

  if (NodeLvl = 1) then
  begin
    fs:= TFormatSettings.Create;
    edtPriceCost.Text:= Format('%2.2f',[Data^.CurrentCost]);
  end;
end;

procedure TForm1.actNodeExpandExecute(Sender: TObject);
var
  NodeLvl: Integer;
  Node: PVirtualNode;
begin
  if (vst.SelectedCount <> 1) then Exit;

  Node:= vst.GetFirstSelected;
  if not Assigned(Node) then Exit;
  NodeLvl:= vst.GetNodeLevel(Node);

  if (NodeLvl <> 0) then Node:= Node.Parent;
  vst.Expanded[Node]:= True;
end;

procedure TForm1.ActNodeRestoreExecute(Sender: TObject);
var
  Nodes: TNodeArray;
  Data: PMyRec;
  i: Integer;
  chNode: PVirtualNode;
begin
  if (vst.SelectedCount = 0) then Exit;

  Nodes:= vst.GetSortedSelection(True);

  for i := 0 to Pred(System.Length(Nodes)) do
  begin
    if (vst.GetNodeLevel(Nodes[i]) = 0)
    then
      begin
        Data:= vst.GetNodeData(Nodes[i]);

        if Assigned(Data) then
        begin
          Data^.CurrentChangeType:= Data^.LastChangeType;

          if (vsHasChildren in Nodes[i]^.States) then
          begin
            chNode:=  Nodes[i]^.FirstChild;

            while Assigned(chNode) do
            begin
              Data:= vst.GetNodeData(chNode);

              if Assigned(Data) then
              begin
                Data^.CurrentChangeType:= Data^.LastChangeType;
                chNode:= chNode.NextSibling;
              end;
            end;
          end;
        end;
      end
    else
      begin
        //check if there is a parent
        if Assigned(Nodes[i].Parent) then
        begin
          Data:= vst.GetNodeData(Nodes[i].Parent);
          if Assigned(Data) then
            if (Data^.CurrentChangeType = tctDeleted)
              then Data^.CurrentChangeType:= Data^.LastChangeType;
        end;

        Data:= vst.GetNodeData(Nodes[i]);
        if Assigned(Data) then Data^.CurrentChangeType:= Data^.LastChangeType;
      end;
  end;

  vst.Refresh;
  if vst.CanFocus then vst.SetFocus;

  ActChkStatusBtnExecute(Sender);
end;

procedure TForm1.actAllCollapsExecute(Sender: TObject);
begin
  vst.FullCollapse(nil);
end;

procedure TForm1.actAllExpandExecute(Sender: TObject);
begin
  vst.FullExpand(nil);
end;

procedure TForm1.ActChildAddExecute(Sender: TObject);
var
  tmpCurr: Currency;
  fs: TFormatSettings;
  NodeLvl: Integer;
begin
  if (vst.SelectedCount = 0) then
  begin
    Application.MessageBox('Должен выделен хотя бы один узел!','Недостаточно данных', MB_ICONINFORMATION);
    Exit;
  end;

  fs:= TFormatSettings.Create;
  actEdtNodeDataOnExecute(Sender);
  pnlEdtCost.Visible:= True;
  edtPriceName.Clear;
  edtPriceCost.Text:= '0';

  if TryStrToCurr(edtPriceCost.Text, tmpCurr,fs)
    then edtPriceCost.Text:= Format('%2.2f',[tmpCurr])
    else edtPriceCost.Clear;

  FNodeSender:= vst.GetFirstSelected;
  FActionNodeSender:= ansNodeChild;

  if edtPriceName.CanFocus then edtPriceName.SetFocus;
end;

procedure TForm1.actPriceFillExecute(Sender: TObject);
var
  Node, ChdNode: PVirtualNode;
  Data: PMyRec;
  NodeID: integer;//ID of current Node
  RootID: Integer;//parent ID of current Node

begin
  EditMode:= emEdit;
  if not mds_price.Active then Exit;

  try
    vst.BeginUpdate;
    vst.Clear;

    mds_price.DisableControls;
    if mds_labor.Active
      then mds_labor.EmptyTable
      else mds_labor.Active:= True;

    try
      tmpTrans.StartTransaction;

      with tmpQry do
      begin
        Close;
        SQL.Text:= SQLTextTblIssueSelect;
        ExecQuery;

        while not Eof do
        begin
          mds_labor.AppendRecord([
                    FieldByName('LABORISSUE_ID').AsInteger,
                    FieldByName('LABORISSUE_NAME').AsString
                              ]);
          Next;
        end;
      end;
      tmpTrans.Commit;
    except
      on E: EFIBError do
      begin
        tmpTrans.Rollback;
        Application.MessageBox(PChar(E.Message), 'Ошибка доступа к данным', MB_ICONERROR);
      end;
    end;

    mds_labor.First;

    while not mds_labor.Eof do
    begin
      mds_price.Filtered:= False;
      mds_price.Filter:= Format('(UPPER(NAME_PRICE) LIKE UPPER(''%%%s%%'')) AND (LABORISSUE_ID=%d)',
                                [PriceName, mds_labor.FieldByName('LABORISSUE_ID').AsInteger]);
      mds_price.Filtered:= True;

      if not mds_price.IsEmpty then
      begin
        mds_price.First;

        Node:= vst.AddChild(nil);
        Data:= vst.GetNodeData(Node);

        case EditMode of
          emAdd:
            begin
              NodeID:= vst.AbsoluteIndex(Node);
              RootID:= 0;
              FTreeChangeType:= tctInserted;
            end;
          emEdit:
            begin
              NodeID:= mds_price.FieldByName('BASEPRICE_ID').AsInteger;
              RootID:= mds_price.FieldByName('LABORISSUE_ID').AsInteger;
              FTreeChangeType:= tctNone;
            end;
        end;

        if Assigned(Data) then
        begin
          Data^.PriceID:= NodeID;
          Data^.DepartID:= RootID;
          Data^.CurrentChangeType:= TreeChangeType;
          Data^.LastChangeType:= TreeChangeType;
          Data^.PriceName:= mds_price.FieldByName('LABORISSUE_NAME').AsString;
          Data^.CurrentCost:= 0;
          Data^.LastCost:= 0;

          RootID:= NodeID;

          while not mds_price.Eof do
          begin
            ChdNode:= vst.AddChild(Node);
            Data:= vst.GetNodeData(ChdNode);

            case EditMode of
              emAdd: NodeID:= vst.AbsoluteIndex(ChdNode);
              emEdit: NodeID:= mds_price.FieldByName('BASEPRICE_ID').AsInteger;
            end;

            if Assigned(Data) then
            begin
              Data^.PriceID:= NodeID;
              Data^.DepartID:= RootID;
              Data^.CurrentChangeType:= TreeChangeType;
              Data^.LastChangeType:= TreeChangeType;
              Data^.PriceName:= mds_price.FieldByName('BASEPRICE_PROC_NAME').AsString;
              Data^.CurrentCost:= mds_price.FieldByName('COST_PROC_PRICE').AsCurrency;
              Data^.LastCost:= mds_price.FieldByName('COST_PROC_PRICE').AsCurrency;
            end;

            mds_price.Next;
          end;

        end;{Assigned(Data) of Node}
      end; {not mds_price.IsEmpty}

      mds_labor.Next;
    end;
  finally

    mds_price.Filtered:= False;
    mds_price.Filter:= Format('UPPER(NAME_PRICE) LIKE UPPER(''%%%s%%'')',[PriceName]);
    mds_price.Filtered:= True;

    mds_price.EnableControls;
    vst.EndUpdate;
  end;

end;

procedure TForm1.cbbPriceChange(Sender: TObject);
begin
  FPriceName:= cbbPrice.Items[cbbPrice.ItemIndex];

  if not mds_price.Active then Exit;

  mds_price.DisableControls;
  try
    mds_price.Filtered:= False;
    mds_price.Filter:= Format('UPPER(NAME_PRICE) LIKE UPPER(''%%%s%%'')',[PriceName]);
    mds_price.Filtered:= True;
  finally
    mds_price.EnableControls;
  end;
end;

procedure TForm1.edtPriceCostChange(Sender: TObject);
var
  tmpCurr: Currency;
  fs: TFormatSettings;
begin
//  Exit;
//  try
//    tmpCurr:= StrToCurr(edtPriceCost.Text);
//    Label1.Caption:= Format('%2.2f',[tmpCurr])
//  except
//    on E:  EConvertError do
//    begin
//      Label1.Caption:= '<некорректное значение>';
//      ShowMessage(E.Message);
//    end;
//  end;
  fs:= TFormatSettings.Create;
  if TryStrToCurr(edtPriceCost.Text, tmpCurr,fs) then
  begin
//    Label1.Caption:= Format('%2.2f',[tmpCurr]);
//    udPriceCost.Position:= Trunc(tmpCurr);
  end;

end;

procedure TForm1.edtPriceCostKeyPress(Sender: TObject; var Key: Char);
var
  fs: TFormatSettings;
begin
  fs:= TFormatSettings.Create;
  if not (Key in ['0'..'9','-',fs.DecimalSeparator]) then Key:= #0;
end;

procedure TForm1.FillCbbPrice(Sender: TObject);
var
  k: Integer;
begin
  cbbPrice.OnChange:= nil;
  try
    tmpTrans.StartTransaction;

    tmpQry.Close;
    tmpQry.SQL.Text:= SQLTextTblPriceSelect;
    tmpQry.ExecQuery;

    cbbPrice.Clear;

    try
      if (tmpQry.RecordCount = 0)
      then
        begin
          cbbPrice.Enabled:= False;
          cbbPrice.Style:= csDropDown;
          cbbPrice.Font.Color:= clGrayText;
          cbbPrice.Items.AddObject('тут ничего нет!', TObject(0));
          cbbPrice.ItemIndex:= 0;
        end
      else
        begin
          cbbPrice.Enabled:= True;
          cbbPrice.Style:= csDropDownList;
          cbbPrice.Font.Color:= clWindowText;

          while not tmpQry.Eof do
          begin
            cbbPrice.Items.AddObject(tmpQry.FieldByName('NAME_PRICE').AsString,
                            TObject(tmpQry.FieldByName('ID_PRICE').AsInteger));

            tmpQry.Next;
          end;

          k:= cbbPrice.Items.IndexOf(PriceName);

          if (k <> -1)
            then cbbPrice.ItemIndex:= k
            else cbbPrice.ItemIndex:= 0;
        end;

        tmpTrans.Commit;
    except
      on E: EFIBError do
      begin
        tmpTrans.Rollback;
        Application.MessageBox(PChar(E.Message), 'Ошибка доступа к данным', MB_ICONERROR);
      end;
    end;
  finally
    cbbPrice.OnChange:= cbbPriceChange;
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  vst.ClearSelection;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  with tmpDB do
  begin
    DBName:= connstr;
    LibraryName:= libname;
    DBParams.Add(usrname);
    DBParams.Add(pwd);
    DBParams.Add(chrset);
    DefaultTransaction:= tmpTrans;
    SQLDialect:= 3;
  end;

  FClinicID:= -1;
  FPeolpeID:= -1;
  FDoctorID:= -1;
  FPriceName:= '';
  FFilterStr:= '';
  FTreeChangeType:= tctInserted;
  FNodeSender:= nil;
  EditMode:= emAdd;
  edtPriceName.MaxLength:= 100;


  with mds_price do
  begin
    FieldDefs.Add('BASEPRICE_ID', ftInteger);
    FieldDefs.Add('BASEPRICE_PROC_NAME', ftString, 100);
    FieldDefs.Add('COST_PROC_PRICE', ftCurrency);
    FieldDefs.Add('LABORISSUE_ID', ftInteger);
    FieldDefs.Add('LABORISSUE_NAME', ftString, 100);
    FieldDefs.Add('NAME_PRICE', ftString,40);

    CreateDataSet;
    Filtered:= False;
    Active := False;
  end;

   with mds_src do
  begin
    FieldDefs.Add('BASEPRICE_ID', ftInteger);
    FieldDefs.Add('BASEPRICE_PROC_NAME', ftString, 100);
    FieldDefs.Add('COST_PROC_PRICE', ftCurrency);
    FieldDefs.Add('LABORISSUE_ID', ftInteger);
    FieldDefs.Add('LABORISSUE_NAME', ftString, 100);
    FieldDefs.Add('NAME_PRICE', ftString,40);

    CreateDataSet;
    Filtered:= False;
    Active := False;
  end;

  with mds_labor do
  begin
    FieldDefs.Add('LABORISSUE_ID', ftInteger);
    FieldDefs.Add('LABORISSUE_NAME', ftString, 100);

    CreateDataSet;
    Filtered:= False;
    Active := False;
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  tmpDB.Connected:= True;

  if mds_price.Active
    then mds_price.EmptyTable
    else mds_price.Active:= True;

  if mds_src.Active
    then mds_src.EmptyTable
    else mds_src.Active:= True;


  try
    mds_price.DisableControls;
    try
      tmpTrans.StartTransaction;

      with tmpQry do
      begin
        Close;
        SQL.Text:= SQLTextRep;
        ExecQuery;

        while not Eof do
        begin
             mds_price.AppendRecord([
                  FieldByName('BASEPRICE_ID').AsInteger,
                  FieldByName('BASEPRICE_PROC_NAME').AsString,
                  FieldByName('COST_PROC_PRICE').AsCurrency,
                  FieldByName('LABORISSUE_ID').AsInteger,
                  FieldByName('LABORISSUE_NAME').AsString,
                  FieldByName('NAME_PRICE').AsString
                                ]);

             mds_src.AppendRecord([
                  FieldByName('BASEPRICE_ID').AsInteger,
                  FieldByName('BASEPRICE_PROC_NAME').AsString,
                  FieldByName('COST_PROC_PRICE').AsCurrency,
                  FieldByName('LABORISSUE_ID').AsInteger,
                  FieldByName('LABORISSUE_NAME').AsString,
                  FieldByName('NAME_PRICE').AsString
                                ]);
          Next;
        end;
      end;
      tmpTrans.Commit;

      mds_price.First;

      FillCbbPrice(Sender);
      cbbPriceChange(Sender);
      pnlTblPrice.Visible:= False;
      actPriceFillExecute(Sender);
      vst.FullExpand(nil);
      actEdtNodeDataOffExecute(Sender);
    except
      on E: EFIBError do
      begin
        tmpTrans.Rollback;
        Application.MessageBox(PChar(E.Message), 'Ошибка доступа к данным', MB_ICONERROR);
      end;
    end;
  finally
    mds_price.EnableControls;
  end;
end;

procedure TForm1.vstAddToSelection(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Data: PMyRec;
  ss, ss1: string;
begin
  Data:= Sender.GetNodeData(Node);
  if Assigned(Data) then
  begin
    FTreeChangeType:= Data.CurrentChangeType;

    case TreeChangeType of
      tctNone: ss:= 'tctNone';
      tctDeleted: ss:= 'tctDeleted';
      tctInserted: ss:= 'tctInserted';
      tctUpdated: ss:= 'tctUpdated';
    end;

    if Sender.Expanded[node]
      then ss1:= 'Expanded[node] = True'
      else ss1:= 'Expanded[node] = False';


    Self.Caption:= Format('PriceID: %d | DepartID: %d | index: %d | PriceName: %s | ChangeType: %s | %s',[
      Data^.PriceID,
      Data^.DepartID,
      Node^.Index,
      Data^.PriceName,
      ss,
      ss1
                            ]);
  end;

  ActChkStatusBtnExecute(Sender);
  ActChkStatusMnuVSTExecute(Sender);
end;

procedure TForm1.vstCollapsed(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
//  actNodeCollaps.Enabled:= ((vst.SelectedCount = 1) and (vsExpanded in Node^.States));
//  actNodeExpand.Enabled:= ((vst.SelectedCount = 1) and not (vsExpanded in Node^.States));
  ActChkStatusMnuVSTExecute(Sender);
end;

procedure TForm1.vstDragDrop(Sender: TBaseVirtualTree; Source: TObject; DataObject: IDataObject; Formats: TFormatArray;
  Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
var
  NodeLvl: Integer;

//  pSource,
  NodeTarget: PVirtualNode;//receiving node
  Nodes: TNodeArray;//moving nodes
  attMode: TVTNodeAttachMode;
  DataTarget: PMyRec;
  DataSource: PMyRec;
  i: Integer;
begin
{$REGION 'skiped'}
  //  if (Source <> Sender) then Exit;

  //  Nodes:= Sender.GetSortedSelection(True);
  //
  //  IsAllow:= True;
  //
  //  for i:= 0 to Pred(System.Length(Nodes)) do
  //  begin
  //    NodeLvl:= vst.GetNodeLevel(Nodes[i]);
  //    if  (NodeLvl = 0) then
  //    begin
  //      IsAllow:= False;
  ////      Break;
  //      Exit;
  //    end;
  //  end;
  //
  //  if IsAllow
  //    then ShowMessage('только детки')
  //    else ShowMessage('есть root');
{$ENDREGION}
//  pSource := TVirtualStringTree(Source).FocusedNode;
  NodeTarget := Sender.DropTargetNode;
  Nodes:= TVirtualStringTree(Source).GetSortedSelection(True);


  case Mode of
    dmNowhere: attMode := amNoWhere;
    dmAbove:
      begin
        DataTarget:=Sender.GetNodeData(NodeTarget);
        Self.Caption:= Self.Caption + ' | ' + DataTarget^.PriceName + ' | index = ' + IntToStr(NodeTarget^.Index);
        NodeLvl:= Sender.GetNodeLevel(NodeTarget);

        case NodeLvl of
          0: attMode := amAddChildFirst;
          1: attMode := amInsertBefore;
        end;
      end;
    dmOnNode:
      begin
        DataTarget:=Sender.GetNodeData(NodeTarget);
        Self.Caption:= Self.Caption + ' | ' + DataTarget^.PriceName + ' | index = ' + IntToStr(NodeTarget^.Index);
        NodeLvl:= Sender.GetNodeLevel(NodeTarget);

        case NodeLvl of
          0: attMode := amAddChildFirst;
          1: attMode := amInsertAfter;
        end;
      end;
     dmBelow:
     begin
        DataTarget:=Sender.GetNodeData(NodeTarget);
        Self.Caption:= Self.Caption + ' | ' + DataTarget^.PriceName + ' | index = ' + IntToStr(NodeTarget^.Index);
        NodeLvl:= Sender.GetNodeLevel(NodeTarget);

        case NodeLvl of
          0: attMode := amAddChildFirst;
          1: attMode := amInsertAfter;
        end;
     end;
  end;

  NodeLvl:= Sender.GetNodeLevel(NodeTarget);

  case NodeLvl of
    0: DataTarget:= Sender.GetNodeData(NodeTarget);
    1: DataTarget:= Sender.GetNodeData(NodeTarget.Parent);
  end;

  //move the nodes and change their ParentID to match the current root node
  for i := 0 to Pred(System.Length(Nodes)) do
    begin
      Sender.MoveTo(Nodes[i], NodeTarget, attMode, False);
      DataSource:= TVirtualStringTree(Source).GetNodeData(Nodes[i]);
      DataSource.DepartID:= DataTarget.PriceID;
    end;
end;

procedure TForm1.vstDragOver(Sender: TBaseVirtualTree; Source: TObject; Shift: TShiftState; State: TDragState;
  Pt: TPoint; Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
var
  Nodes: TNodeArray;
  NodeLvl: Integer;
  i: Integer;
  Data: PMyRec;
  drgNode,tgtNode: PVirtualNode;
begin
  if (Sender <> Source) then Exit;
  tgtNode:= Sender.DropTargetNode;//node we are above or around
  drgNode:= TBaseVirtualTree(Source).GetFirstSelected;//first dragged node

  if (Assigned(tgtNode) and Assigned(drgNode)) then
  begin
    if ((drgNode.Parent = tgtNode.Parent) or (drgNode.Parent = tgtNode)) then Exit;
  end;

  Nodes:= Sender.GetSortedSelection(True);
  Accept:= True;

  for i := 0 to Pred(System.Length(Nodes)) do
  begin
    NodeLvl:= Sender.GetNodeLevel(Nodes[i]);
    if (NodeLvl = 0) then
    begin
      Accept:= False;
      Exit;
    end;
  end;
end;

procedure TForm1.vstEditing(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
var
  Data: PMyRec;
  NodeLvl: Integer;
begin
  //restrict editing the "cost" of the price list sections
  Allowed:= False;
  NodeLvl:= Sender.GetNodeLevel(Node);
  Data:= Sender.GetNodeData(Node);

  if not Assigned(Data) then Exit;
  Allowed:= not ((Column = 1) and (NodeLvl = 0));
end;

procedure TForm1.vstExpanded(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  ActChkStatusMnuVSTExecute(Sender);
end;

procedure TForm1.vstFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Data: PMyRec;
begin
  Data:= Sender.GetNodeData(Node);

  if Assigned(Data) then
  begin
    Finalize(Data^);
  end;
end;

procedure TForm1.vstGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
begin
  NodeDataSize:= SizeOf(TMyRec);
end;

procedure TForm1.vstGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  NodeLvl: Integer;
  Data: PMyRec;
  fs: TFormatSettings;
begin
  Data:= Sender.GetNodeData(Node);

  if not Assigned(Data) then Exit;
  NodeLvl:= Sender.GetNodeLevel(Node);

{$REGION 'skiped'}
  //  mds_src.Locate('BASEPRICE_ID', Data^.PriceID,[]);
  //  case NodeLvl of
  //    0:
  //      begin
  //        case Column of
  //          0: CellText:= mds_src.FieldByName('LABORISSUE_NAME').AsString;
  //          1: CellText:= '';
  //        end;
  //      end;
  //    1:
  //      begin
  //        fs:= TFormatSettings.Create;
  //        CurrVar:= mds_src.FieldByName('COST_PROC_PRICE').AsCurrency;
  //        case Column of
  //          0: CellText:= mds_src.FieldByName('BASEPRICE_PROC_NAME').AsString;
  //          1: CellText:= Format('%2.2f %s',[CurrVar, fs.CurrencyString]);
  //        end;
  //      end;
  //  end;
{$ENDREGION}

  case NodeLvl of
    0:
      case Column of
        0: CellText:= Data^.PriceName;
        1: CellText:= '';
      end;
    1:
      case Column of
        0: CellText:= Data^.PriceName;
        1: CellText:= Format('%2.2f %s',[Data^.CurrentCost, fs.CurrencyString]);
      end;
  end;
end;

procedure TForm1.vstInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
begin
//  Node.CheckType:= ctTriStateCheckBox;
end;

procedure TForm1.vstKeyPress(Sender: TObject; var Key: Char);
var
  Node: PVirtualNode;
  NodeLvl: Integer;
  fs: TFormatSettings;
begin
  Exit;
  Node:= vst.GetFirstSelected(True);
  NodeLvl:= vst.GetNodeLevel(Node);
  if ((NodeLvl = 1) and (vst.Header.Columns.ClickIndex = 1)) then
  begin
    fs:= TFormatSettings.Create;
    if (Key in ['0'..'9']) then Key:= #0;
  end;
end;

procedure TForm1.vstNewText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; NewText: string);
var
  Data: PMyRec;
  NodeLvl: Integer;
  fs: TFormatSettings;
begin
//  if (Trim(NewText) = '') then Exit;
//
//  Data:= Sender.GetNodeData(Node);
//  NodeLvl:= Sender.GetNodeLevel(Node);
//  fs:= TFormatSettings.Create;
//
//  case NodeLvl of
//    0:
//      case Column of
//        0: Data^.PriceName:= NewText;
////        1: Exit;
//      end;
//    1:
//      case Column of
//        0: Data^.PriceName:= NewText;
//        1:
//          begin
//            NewText:= StringReplace(NewText,'.',',',[rfReplaceAll, rfIgnoreCase]);
//            Data^.CurrentCost:= StrToCurr(NewText, fs);
//          end;
//      end;
//  end;
end;

procedure TForm1.vstNodeClick(Sender: TBaseVirtualTree; const HitInfo: THitInfo);
begin
//
end;

procedure TForm1.vstPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType);
var
  Data: PMyRec;
begin
  Data:= Sender.GetNodeData(Node);

  if Assigned(Data) then
    if (Data^.CurrentChangeType = tctDeleted) then
    begin
      TargetCanvas.Font.Style:= [TFontStyle.fsStrikeOut];
      TargetCanvas.Font.Color:= clGrayText;
    end;
end;

procedure TForm1.vstRemoveFromSelection(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  ActChkStatusBtnExecute(Sender);
//  ActChkStatusBtnUpdate(Sender);
end;

end.
