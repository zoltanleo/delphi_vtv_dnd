﻿unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, MemTableDataEh, Data.DB, MemTableEh, DBGridEhGrouping,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, FIBQuery, pFIBQuery, FIBDatabase, pFIBDatabase, EhLibVCL, GridsEh,
  DBAxisGridsEh, DBGridEh, fib, Vcl.ComCtrls, VirtualTrees, Vcl.ExtCtrls, System.Actions, Vcl.ActnList
  , Winapi.ActiveX, Vcl.Samples.Spin, Vcl.Menus
  , Generics.Collections
  , System.UITypes
  ;

type
  TTreeChangeType = (tctExisting, tctDeleted, tctInserted, tctUpdated, tctNew);
  TEditMode = (emAdd, emEdit);
  TActionNodeSender = (ansNodeRoot, ansNodeChild, ansNodeEdit);

  PMyRec = ^TMyRec;
  TMyRec = record
    PriceID: Integer;
    DepartID: Integer;
    CurrentChangeType: TTreeChangeType;
    LastChangeType: TTreeChangeType;
    ItemName: string;
    CurrentCost: Currency;
    InitCost: Currency;
    CodeLiter: string;
    ExistStatus: TTreeChangeType;
  end;

  TForm1 = class(TForm)
    tmpDB: TpFIBDatabase;
    tmpTrans: TpFIBTransaction;
    tmpQry: TpFIBQuery;
    ds_price: TDataSource;
    mds_common: TMemTableEh;
    actList: TActionList;
    actPriceFill: TAction;
    actPriceDel: TAction;
    mds_laborissue: TMemTableEh;
    mds_src: TMemTableEh;
    pnlTbl: TPanel;
    DBGridEh1: TDBGridEh;
    pnlTree: TPanel;
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
    pnlTreeSettings: TPanel;
    chbSetZeroCost: TCheckBox;
    chbShowUpdatedPrice: TCheckBox;
    chbHideDelNode: TCheckBox;
    Button1: TButton;
    actPriceEdt: TAction;
    actPriceAdd: TAction;
    pnlSetPriceName: TPanel;
    edtSetPriceName: TEdit;
    actTreeShowOn: TAction;
    actTreeShowOff: TAction;
    btnPriceSave: TButton;
    btnPriceCancel: TButton;
    actPriceSave: TAction;
    actPriceCancel: TAction;
    pnlEdtCodeLiter: TPanel;
    edtCodeLiter: TEdit;
    ActItemSelect: TAction;
    pnlItemSelect: TPanel;
    btnItemSelect: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    mds_baseprice: TMemTableEh;
    mds_price: TMemTableEh;
    qryLaborissue: TpFIBQuery;
    qryBaseprice: TpFIBQuery;
    qryPriceItemInsert: TpFIBQuery;
    qryPriceItemUpdate: TpFIBQuery;
    qryPriceItemDelete: TpFIBQuery;
    actGetCommonData: TAction;
    actSetPriceFilter: TAction;
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
    procedure chbSetZeroCostClick(Sender: TObject);
    procedure chbShowUpdatedPriceClick(Sender: TObject);
    procedure vstHeaderDrawQueryElements(Sender: TVTHeader; var PaintInfo: THeaderPaintInfo;
      var Elements: THeaderPaintElements);
    procedure vstAdvancedHeaderDraw(Sender: TVTHeader; var PaintInfo: THeaderPaintInfo;
      const Elements: THeaderPaintElements);
    procedure vstHeaderDraw(Sender: TVTHeader; HeaderCanvas: TCanvas; Column: TVirtualTreeColumn; R: TRect; Hover,
      Pressed: Boolean; DropMark: TVTDropMarkMode);
    procedure chbHideDelNodeClick(Sender: TObject);
    procedure actPriceEdtExecute(Sender: TObject);
    procedure actPriceAddExecute(Sender: TObject);
    procedure actTreeShowOnExecute(Sender: TObject);
    procedure actTreeShowOffExecute(Sender: TObject);
    procedure actPriceCancelExecute(Sender: TObject);
    procedure actPriceSaveExecute(Sender: TObject);
    procedure actPriceDelExecute(Sender: TObject);
    procedure edtCodeLiterKeyPress(Sender: TObject; var Key: Char);
    procedure ActItemSelectExecute(Sender: TObject);
    procedure actGetCommonDataExecute(Sender: TObject);
    procedure actSetPriceFilterExecute(Sender: TObject);
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
    FInitPriceItemValue: string;
    FIsPickedNode: Boolean;
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
    property InitPriceItemValue: string read FInitPriceItemValue;
    property IsPickedNode: Boolean read FIsPickedNode;
  end;

const
  libname = 'c:\firebird\fb_3_0_10_x32\fbclient.dll';
  connstr = '127.0.0.1/31064:c:\proj\test_delphi\delphi_vtv_dnd\base\Price.fdb';
  usrname = 'user_name=SYSDBA';
  pwd = 'password=cooladmin';
  chrset = 'lc_ctype=WIN1251';
  repPath = 'c:\proj\test_delphi\db_test\reports\';
//  cPriceName = 'Прайс Биомед 01.03.2022';
//  RepDSFilter = '(LABORISSUE_ID=2) OR (LABORISSUE_ID=3)';

  {$REGION 'table baseprice'}
     SQLTextTblBasepriceSelect =
      'SELECT ' +
        'BASEPRICE_ID, ' +
        'BASEPRICE_PROC_CODE, ' +
        'BASEPRICE_PROC_NAME, ' +
        'BASEPRICE_PROC_ISSUE_FK ' +
      'FROM TBL_BASEPRICE ' +
      'ORDER BY 1';

     SQLTextTblBasepriceInsert =
      'INSERT INTO TBL_BASEPRICE (' +
//        'BASEPRICE_ID, ' +
//        'BASEPRICE_PROC_CODE, ' +
        'BASEPRICE_PROC_NAME, ' +
        'BASEPRICE_PROC_ISSUE_FK) ' +
      'VALUES (' +
//        ':BASEPRICE_ID, ' +
//        ':BASEPRICE_PROC_CODE, ' +
        ':BASEPRICE_PROC_NAME, ' +
        ':BASEPRICE_PROC_ISSUE_FK) ' +
      'RETURNING BASEPRICE_ID';

//    SQLTextTblBasepriceUpdate =
//      'UPDATE TBL_BASEPRICE ' +
//      'SET ' +
//        'BASEPRICE_PROC_CODE = :BASEPRICE_PROC_CODE, ' +
//        'BASEPRICE_PROC_NAME = :BASEPRICE_PROC_NAME, ' +
//        'BASEPRICE_PROC_ISSUE_FK = :BASEPRICE_PROC_ISSUE_FK ' +
//      'WHERE (BASEPRICE_ID = :BASEPRICE_ID)';
//
//    SQLTextTblBasepriceDelete =
//      'DELETE FROM TBL_BASEPRICE ' +
//      'WHERE (BASEPRICE_ID = :BASEPRICE_ID)';
  {$ENDREGION}
  {$REGION 'table price'}
    SQLTextTblPriceSelect =
      'SELECT ' +
        'MAX(ID_PRICE) AS ID_PRICE, ' +
        'NAME_PRICE ' +
      'FROM TBL_PRICE ' +
      'GROUP BY NAME_PRICE ' +
      'ORDER BY 1 DESC';

    SQLTextTblPriceItemInsert =
      'INSERT INTO TBL_PRICE (' +
        'FK_BASEPRICE,' +
        'NAME_PRICE,' +
        'COST_PROC_PRICE) ' +
      'VALUES (' +
        ':FK_BASEPRICE,' +
        ':NAME_PRICE,' +
        ':COST_PROC_PRICE)';

    SQLTextTblPriceItemUpdate =
      'UPDATE TBL_PRICE ' +
      'SET COST_PROC_PRICE = :COST_PROC_PRICE ' +
      'WHERE (FK_BASEPRICE = :FK_BASEPRICE) AND (NAME_PRICE = :NAME_PRICE)';

    SQLTextTblPriceItemDelete =
      'DELETE FROM TBL_PRICE ' +
      'WHERE (FK_BASEPRICE = :FK_BASEPRICE) AND (NAME_PRICE = :NAME_PRICE)';

    SQLTextTblPriceDelete =
      'DELETE FROM TBL_PRICE ' +
      'WHERE (NAME_PRICE = :NAME_PRICE)';
  {$ENDREGION}
  {$REGION 'table laborissue'}
    SQLTextTblLaborIssueSelect =
      'SELECT ' +
          'LABORISSUE_ID, ' +
          'LABORISSUE_NAME, ' +
          'LABORISSUE_CODELITER ' +
      'FROM TBL_LABORISSUE ' +
      'ORDER BY 1';

    SQLTextTblLaborIssueInsert =
      'INSERT INTO TBL_LABORISSUE (' +
        'LABORISSUE_NAME, ' +
        'LABORISSUE_CODELITER) ' +
      'VALUES (' +
        ':LABORISSUE_NAME, ' +
        ':LABORISSUE_CODELITER) ' +
      'RETURNING LABORISSUE_ID';
  {$ENDREGION}

  SQLTextTblItemsSelect =
    'SELECT ' +
        'LI.LABORISSUE_ID, ' +
        'LI.LABORISSUE_NAME, ' +
        'LI.LABORISSUE_CODELITER, ' +
        'BP.BASEPRICE_ID, ' +
        'BP.BASEPRICE_PROC_NAME ' +
    'FROM TBL_BASEPRICE BP ' +
       'INNER JOIN TBL_LABORISSUE LI ' +
       'ON (BP.BASEPRICE_PROC_ISSUE_FK = LI.LABORISSUE_ID) ' +
    'WHERE LI.LABORISSUE_NAME = :LABORISSUE_NAME';

  SQLTextResultSelect =
      'SELECT ' +
          'BP.BASEPRICE_ID, ' +
          'BP.BASEPRICE_PROC_NAME, ' +
          'P.COST_PROC_PRICE, ' +
          'LI.LABORISSUE_ID, ' +
          'LI.LABORISSUE_NAME, ' +
          'LI.LABORISSUE_CODELITER, ' +
          'P.NAME_PRICE ' +
      'FROM TBL_LABORISSUE LI ' +
         'JOIN TBL_BASEPRICE BP ON (LI.LABORISSUE_ID = BP.BASEPRICE_PROC_ISSUE_FK) ' +
         'JOIN TBL_PRICE P ON (BP.BASEPRICE_ID = P.FK_BASEPRICE) ' +
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

uses uItem;

procedure TForm1.ActRootAddExecute(Sender: TObject);
var
  NodeLvl: Integer;
begin
//  pnlEdtCost.Visible:= False;
//  pnlEdtCodeLiter.Visible:= not pnlEdtCost.Visible;
  edtPriceName.Clear;
  edtCodeLiter.Clear;
  edtPriceCost.Text:= '0';

  FActionNodeSender:= ansNodeRoot;

  if (vst.SelectedCount > 0)
    then FNodeSender:= vst.GetFirstSelected
    else FNodeSender:= nil;

  actEdtNodeDataOnExecute(Sender);

  if edtPriceName.CanFocus then edtPriceName.SetFocus;
end;

procedure TForm1.actSetPriceFilterExecute(Sender: TObject);
begin
  if not mds_common.Active then Exit;

  mds_common.DisableControls;
  try
    mds_common.Filtered:= False;
    mds_common.Filter:= Format('UPPER(NAME_PRICE) LIKE UPPER(''%%%s%%'')',[PriceName]);
    mds_common.Filtered:= True;
  finally
    mds_common.EnableControls;
  end;
end;

procedure TForm1.actTreeShowOffExecute(Sender: TObject);
begin
  pnlTbl.Visible:= True;
  pnlTree.Visible:= not pnlTbl.Visible;
end;

procedure TForm1.actTreeShowOnExecute(Sender: TObject);
var
  Node: PVirtualNode;
begin
  chbSetZeroCost.Enabled:= (EditMode = emAdd);
  chbShowUpdatedPrice.Enabled:= (EditMode = emEdit);

  actEdtNodeDataOffExecute(Sender);
  vst.FullExpand(nil);

  pnlTbl.Visible:= False;
  pnlTree.Visible:= not pnlTbl.Visible;
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
        Node:= vst.GetFirstSelected;
        Data:= vst.GetNodeData(Node);
        NodeLvl:= vst.GetNodeLevel(Node);

        if Assigned(Data) then
        begin
          ActNodeDel.Enabled:= (Data^.CurrentChangeType <> tctDeleted);
          ActNodeRestore.Enabled:= (Data^.CurrentChangeType = tctDeleted);

          if (Data^.CurrentChangeType <> tctExisting)
            then ActNodeEdt.Enabled:= (Data^.CurrentChangeType <> tctDeleted)
            else ActNodeEdt.Enabled:= ((Data^.CurrentChangeType <> tctDeleted) and (NodeLvl > 0));



          if (NodeLvl = 1) then Data:= vst.GetNodeData(Node.Parent);
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
  btnPriceSave.Enabled:= actPriceSave.Enabled;
  btnPriceCancel.Enabled:= actPriceCancel.Enabled;
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
  IsEdit: Boolean;
begin
  vst.Refresh;
  IsEdit:= False;

  for I := 0 to  Pred(pnlTreeView.ControlCount) do
  begin
    if TObject(pnlTreeView.Controls[i]).InheritsFrom(TButton) then
      TButton(pnlTreeView.Controls[i]).Enabled:= not IsEdit;
  end;
  pnlTreeSettings.Enabled:= not IsEdit;
  vst.Enabled:= not IsEdit;

  pnlEdtNodeData.Visible:= IsEdit;
  pnlSetPriceName.Visible:= (not IsEdit and (EditMode = emAdd));

  ActRootAdd.Enabled:= not IsEdit;
  ActChildAdd.Enabled:= not IsEdit;
  ActNodeEdt.Enabled:= not IsEdit;
  ActNodeDel.Enabled:= not IsEdit;
  actPriceSave.Enabled:= not IsEdit;
  actPriceCancel.Enabled:= not IsEdit;

  pnlItemSelect.Align:= alNone;
  pnlEdtCost.Align:= alNone;
  pnlEdtCodeLiter.Align:= alNone;

  ActChkStatusBtnExecute(Sender);

end;

procedure TForm1.actEdtNodeDataOnExecute(Sender: TObject);
var
  i, NodeLvl: Integer;
  IsEdit: Boolean;
begin
  IsEdit:= True;

  for i := 0 to  Pred(pnlTree.ControlCount) do
  begin
    if TObject(pnlTree.Controls[i]).InheritsFrom(TButton) then
      TButton(pnlTree.Controls[i]).Enabled:= not IsEdit;
  end;

  pnlTreeSettings.Visible:= not IsEdit;
  pnlSetPriceName.Visible:= not IsEdit;

  vst.Enabled:= not IsEdit;
  pnlEdtNodeData.Visible:= IsEdit;

  ActRootAdd.Enabled:= not IsEdit;
  ActChildAdd.Enabled:= not IsEdit;
  ActNodeEdt.Enabled:= not IsEdit;
  ActNodeDel.Enabled:= not IsEdit;
  actPriceSave.Enabled:= not IsEdit;
  actPriceCancel.Enabled:= not IsEdit;
  ActItemSelect.Enabled:= (ActionNodeSender <> ansNodeEdit);
  pnlItemSelect.Visible:= ActItemSelect.Enabled;

  case ActionNodeSender of
    ansNodeRoot:
      begin
        pnlEdtCost.Visible:= False;
        pnlEdtCodeLiter.Visible:= not pnlEdtCost.Visible;
      end;
    ansNodeChild:
      begin
        pnlEdtCost.Visible:= True;
        pnlEdtCodeLiter.Visible:= not pnlEdtCost.Visible;
      end;
    ansNodeEdit:
      begin
        NodeLvl:= vst.GetNodeLevel(NodeSender);
        pnlEdtCost.Visible:= (NodeLvl = 1);
        pnlEdtCodeLiter.Visible:= (NodeLvl <> 1);
      end;
  end;

  pnlItemSelect.Align:= alRight;
  pnlEdtCost.Align:= alRight;
  pnlEdtCodeLiter.Align:= alRight;
end;

procedure TForm1.actGetCommonDataExecute(Sender: TObject);
begin
  try
    mds_common.DisableControls;

    if mds_common.Active
    then mds_common.EmptyTable
    else mds_common.Active:= True;

    if mds_src.Active
      then mds_src.EmptyTable
      else mds_src.Active:= True;

    try
      tmpTrans.StartTransaction;

      with tmpQry do
      begin
        Close;
        SQL.Text:= SQLTextResultSelect;
        ExecQuery;

        while not Eof do
        begin
             mds_common.AppendRecord([
                  FieldByName('BASEPRICE_ID').AsInteger,
                  FieldByName('BASEPRICE_PROC_NAME').AsString,
                  FieldByName('COST_PROC_PRICE').AsCurrency,
                  FieldByName('LABORISSUE_ID').AsInteger,
                  FieldByName('LABORISSUE_NAME').AsString,
                  FieldByName('LABORISSUE_CODELITER').AsString,
                  FieldByName('NAME_PRICE').AsString
                                ]);

             mds_src.AppendRecord([
                  FieldByName('BASEPRICE_ID').AsInteger,
                  FieldByName('BASEPRICE_PROC_NAME').AsString,
                  FieldByName('COST_PROC_PRICE').AsCurrency,
                  FieldByName('LABORISSUE_ID').AsInteger,
                  FieldByName('LABORISSUE_NAME').AsString,
                  FieldByName('LABORISSUE_CODELITER').AsString,
                  FieldByName('NAME_PRICE').AsString
                                ]);
          Next;
        end;
      end;
      tmpTrans.Commit;

      mds_common.First;
    except
      on E: EFIBError do
      begin
        tmpTrans.Rollback;
        Application.MessageBox(PChar(E.Message), 'Ошибка доступа к данным', MB_ICONERROR);
      end;
    end;
  finally
    mds_common.EnableControls;
  end;
end;

procedure TForm1.ActItemSelectExecute(Sender: TObject);
var
  tmpFrm: TfrmItem;
  srcNode, destNode: PVirtualNode;
  destData: PTreeItem;
  srcData: PMyRec;
  NodeLvl: Integer;
  fs: TFormatSettings;

  procedure FillIssue;
  begin
    with tmpFrm do
    begin
      try
        if mds_issue.Active
          then mds_issue.EmptyTable
          else mds_issue.Active:= True;

        mds_laborissue.First;

        while not mds_laborissue.Eof do
        begin
          mds_issue.AppendRecord([
              mds_laborissue.FieldByName('LABORISSUE_ID').AsInteger,
              mds_laborissue.FieldByName('LABORISSUE_NAME').AsString,
              mds_laborissue.FieldByName('LABORISSUE_CODELITER').AsString
                                 ]);
          mds_laborissue.Next;
        end;

        if (vst.RootNodeCount > 0) then
        begin
          srcNode:= vst.GetFirst;

          while Assigned(srcNode) do
          begin
            srcData:= vst.GetNodeData(srcNode);

            if Assigned(srcData) then
              if mds_issue.Locate('LABORISSUE_NAME',srcData^.ItemName,[loCaseInsensitive])
                then mds_issue.Delete;

            srcNode:= srcNode.NextSibling;
          end;
        end;

        try
          PriceTree.BeginUpdate;
          PriceTree.Clear;

          if mds_issue.IsEmpty then Exit;

          mds_issue.First;

          while not mds_issue.Eof do
          begin
            destNode:= PriceTree.AddChild(nil);
            destData:= PriceTree.GetNodeData(destNode);
            if Assigned(destData) then
            begin
              destData^.ItemID:= mds_issue.FieldByName('LABORISSUE_ID').AsInteger;
              destData^.ItemName:= mds_issue.FieldByName('LABORISSUE_NAME').AsString;
              destData^.ItemLiter:= mds_issue.FieldByName('LABORISSUE_CODELITER').AsString;
            end;
            mds_issue.Next;
          end;
        finally
          PriceTree.EndUpdate;
        end;
      except
        on E: EFIBError do
        begin
          tmpTrans.Rollback;
          Application.MessageBox(PChar(E.Message), 'Ошибка доступа к данным', MB_ICONERROR);
        end;
      end;
    end;
  end;

  procedure FillItems;
  begin
    if not Assigned(NodeSender) then Exit;
    NodeLvl:= vst.GetNodeLevel(NodeSender);

    case NodeLvl of
      0: srcNode:= NodeSender;
      1: srcNode:= NodeSender.Parent;
    end;

    with tmpFrm do
    begin
      try
        if mds_items.Active
          then mds_items.EmptyTable
          else mds_items.Active:= True;

        srcData:= vst.GetNodeData(srcNode);

        if Assigned(srcData) then
        begin
          mds_baseprice.First;

          while not mds_baseprice.Eof do
          begin
            mds_items.AppendRecord([
              mds_baseprice.FieldByName('BASEPRICE_ID').AsInteger,
              mds_baseprice.FieldByName('BASEPRICE_PROC_CODE').AsString,
              mds_baseprice.FieldByName('BASEPRICE_PROC_NAME').AsString,
              mds_baseprice.FieldByName('BASEPRICE_PROC_ISSUE_FK').AsInteger
                                    ]);
            mds_baseprice.Next;
          end;

          if mds_laborissue.Locate('LABORISSUE_NAME',srcData^.ItemName,[loCaseInsensitive]) then
          begin
            mds_items.Filtered:= False;
            mds_items.Filter:= Format('(BASEPRICE_PROC_ISSUE_FK=%d)',[mds_laborissue.FieldByName('LABORISSUE_ID').AsInteger]);
            mds_items.Filtered:= True;

            if mds_items.IsEmpty then Exit;

            if (srcNode^.ChildCount > 0) then
            begin
              srcNode:= srcNode.FirstChild;

              while Assigned(srcNode) do
              begin
                srcData:= vst.GetNodeData(srcNode);
                if Assigned(srcData) then
                  if mds_items.Locate('BASEPRICE_PROC_NAME',srcData^.ItemName,[loCaseInsensitive])
                    then mds_items.Delete;

                srcNode:= srcNode.NextSibling;
              end;
            end;

          end;

          try
            PriceTree.BeginUpdate;
            PriceTree.Clear;

            if mds_items.IsEmpty then Exit;

            mds_items.First;

            while not mds_items.Eof do
            begin
              destNode:= PriceTree.AddChild(nil);
              destData:= PriceTree.GetNodeData(destNode);

              if Assigned(destData) then
              begin
                destData.ItemID:= mds_items.FieldByName('BASEPRICE_ID').AsInteger;
                destData.ItemName:= mds_items.FieldByName('BASEPRICE_PROC_NAME').AsString;
                destData.ItemLiter:= '';
              end;

              mds_items.Next;
            end;
          finally
            PriceTree.EndUpdate;
          end;
        end;
      except
        on E: EFIBError do
        begin
          tmpTrans.Rollback;
          Application.MessageBox(PChar(E.Message), 'Ошибка доступа к данным', MB_ICONERROR);
        end;
      end;
    end;
  end;

begin
  srcNode:= nil;
  destNode:= nil;
  srcData:= nil;
  destData:= nil;

  tmpFrm:= TfrmItem.Create(Self);
  try
    with tmpFrm do
    begin
      case ActionNodeSender of
        ansNodeRoot: FillIssue;
        ansNodeChild: FillItems;
        ansNodeEdit: Exit;
      end;

      lblEmptyWarninig.Visible:= (PriceTree.RootNodeCount = 0);
      FInitPriceItemValue:= '';
      FIsPickedNode:= False;

      ShowModal;

      if (ModalResult = mrOk) then
      begin
        destNode:= PriceTree.GetFirstSelected;
        if not Assigned(destNode) then Exit;

        destData:= PriceTree.GetNodeData(destNode);
        if Assigned(destData) then
        begin
          edtPriceName.Text:= destData^.ItemName;

          case ActionNodeSender of
            ansNodeRoot:
              begin
                 edtCodeLiter.Text:= UpperCase(destData^.ItemLiter,loUserLocale);
                 edtPriceCost.Clear;
                 udPriceCost.Position:= 0;
                 FInitPriceItemValue:= UpperCase(Format('%s~%s',[edtPriceName.Text, edtCodeLiter.Text]), loUserLocale);
              end;
            ansNodeChild:
              begin
                FInitPriceItemValue:= edtPriceName.Text;
                edtCodeLiter.Clear;
                fs:= TFormatSettings.Create;
                edtPriceCost.Text:= Format('0%s00',[fs.DecimalSeparator]);
                udPriceCost.Position:= 0;
                edtPriceCostChange(Sender);
              end;
            ansNodeEdit: Exit;
          end;
        end;
      end;
      FIsPickedNode:= (ModalResult = mrOk);
    end;
  finally
    FreeAndNil(tmpFrm);
  end;
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
const
  RootPriceItemListExixst =  'Раздел с таким названием в текущем списке уже существует! ' +
                          'Возможно он просто скрыт в настройках и не отображается.';
  ChildPriceItemListExixst =  'Услуга с таким названием в текущем списке уже существует! ' +
                          'Возможно она просто скрыт в настройках и не отображается.';

  RootPriceItemBaseExixst = 'Раздел с таким названием в базе данных уже существует!';
  ChildPriceItemBaseExixst = 'Услуга с таким названием в базе данных уже существует!';
var
  NodeLvl: Integer;
  Node: PVirtualNode;
  rData, Data: PMyRec;
  tmpCurr: Currency;
  fs: TFormatSettings;

  function RootTreeExists(PriceNameText: string): Boolean;
  var
    aNode: PVirtualNode;
    aData: PMyRec;
  begin
    aNode:= nil;
    aData:= nil;

    Result:= False;
    if (vst.RootNodeCount = 0) then Exit;

    aNode:= vst.GetFirst;

    while Assigned(aNode) do
    begin
      aData:= vst.GetNodeData(aNode);

      if Assigned(aData) then
        Result:= (CompareText(aData^.ItemName, Trim(PriceNameText),loUserLocale) = 0);

      if Result then Exit;

      aNode:= aNode.NextSibling;
    end;

  end;

  function ChildTreeExists(PriceNameText: string): Boolean;
  var
    aNode, bNode: PVirtualNode;
    aData: PMyRec;
  begin
    aNode:= nil;
    bNode:= nil;
    aData:= nil;

    Result:= False;
    if (vst.RootNodeCount = 0) then Exit;

    aNode:= vst.GetFirst;

    while Assigned(aNode) do
    begin
      if (vsHasChildren in aNode.States) then
      begin
        bNode:= aNode^.FirstChild;

        while Assigned(bNode) do
        begin
          aData:= vst.GetNodeData(bNode);
          if Assigned(aData) then
            Result:= (CompareStr(aData^.ItemName, Trim(PriceNameText), loUserLocale) = 0);

          if Result then Exit;

          bNode:= bNode.NextSibling;
        end;
      end;

      aNode:= aNode.NextSibling;
    end;
  end;

begin
  Node:= nil;

  if (Trim(edtPriceName.Text) = '') then
  begin
    Application.MessageBox('Поле не может быть пустым!','Некорректные данные',MB_ICONINFORMATION);
    if edtPriceName.CanFocus then edtPriceName.SetFocus;
    Exit;
  end;

  if ((Trim(edtCodeLiter.Text) = '') and (ActionNodeSender = ansNodeRoot)) then
  begin
    Application.MessageBox('Поле не может быть пустым!','Некорректные данные',MB_ICONINFORMATION);
    if edtCodeLiter.CanFocus then edtCodeLiter.SetFocus;
    Exit;
  end;

  {$REGION 'debuging'}
//    var
//    bb: Boolean;
//    ss: string;
//    aa: Integer;
//
//    bb:= mds_labor.Locate('LABORISSUE_NAME',Trim(edtPriceName.Text),[loCaseInsensitive]);
//    ss:= UpperCase(mds_labor.FieldByName('LABORISSUE_NAME').AsString,loUserLocale);//worked
//    ss:= UpperCase(mds_labor.FieldByName('LABORISSUE_NAME').AsString,loInvariantLocale);//not worked
//    ss:= UpperCase(Trim(edtPriceName.Text), loUserLocale);//worked
//    aa:= CompareText(mds_labor.FieldByName('LABORISSUE_NAME').AsString,Trim(edtPriceName.Text));// <> 0 --> not worked
//    aa:= CompareText(mds_labor.FieldByName('LABORISSUE_NAME').AsString,Trim(edtPriceName.Text), loUserLocale); = 0 --> worked

//  if not IsPickedNode then
//  begin
//    if mds_laborissue.Locate('LABORISSUE_NAME',Trim(edtPriceName.Text),[loCaseInsensitive]) then
//    begin
//      Application.MessageBox('В базе данных уже есть раздел с таким названием! Воспользуйтесь кнопкой выбора справа от панели',
//                            'Некорректные данные',MB_ICONINFORMATION);
//      if edtPriceName.CanFocus then edtPriceName.SetFocus;
//      Exit
//    end;
//
//    if mds_laborissue.Locate('LABORISSUE_CODELITER',Trim(edtCodeLiter.Text),[loCaseInsensitive]) then
//    begin
//      Application.MessageBox('Литера кода раздела должна быть уникальной!','Некорректные данные',MB_ICONINFORMATION);
//      if edtCodeLiter.CanFocus then edtCodeLiter.SetFocus;
//      Exit
//    end;
//  end;
  {$ENDREGION}

  case ActionNodeSender of
    ansNodeRoot:
              begin
                if RootTreeExists(edtPriceName.Text)
                then
                  begin
                    Application.MessageBox(PChar(RootPriceItemListExixst),'Некорректные данные',MB_ICONINFORMATION);
                    if edtPriceName.CanFocus then edtPriceName.SetFocus;
                    Exit;
                  end
                else
                  begin
                    if IsPickedNode
                    then
                      begin
                        if (InitPriceItemValue <> UpperCase(Trim(edtPriceName.Text) + '~' + Trim(edtCodeLiter.Text),loUserLocale)) then
                        begin
                          if mds_laborissue.Locate('LABORISSUE_NAME',Trim(edtPriceName.Text),[loCaseInsensitive]) then
                          begin
                            Application.MessageBox(PChar(RootPriceItemBaseExixst),
                                                    'Некорректные данные',MB_ICONINFORMATION);
                            if edtPriceName.CanFocus then edtPriceName.SetFocus;
                            Exit;
                          end;

                          if mds_laborissue.Locate('LABORISSUE_CODELITER',Trim(edtCodeLiter.Text),[loCaseInsensitive]) then
                          begin
                            Application.MessageBox('Раздел с таким значением литеры кода базе данных уже существует!',
                                                    'Некорректные данные',MB_ICONINFORMATION);
                            if edtCodeLiter.CanFocus then edtCodeLiter.SetFocus;
                            Exit;
                          end;
                        end;
                      end
                    else
                      begin
                        if mds_laborissue.Locate('LABORISSUE_NAME',Trim(edtPriceName.Text),[loCaseInsensitive]) then
                        begin
                          Application.MessageBox(PChar(RootPriceItemBaseExixst),
                                                  'Некорректные данные',MB_ICONINFORMATION);
                          if edtPriceName.CanFocus then edtPriceName.SetFocus;
                          Exit;
                        end;

                        if mds_laborissue.Locate('LABORISSUE_CODELITER',Trim(edtCodeLiter.Text),[loCaseInsensitive]) then
                        begin
                          Application.MessageBox('Раздел с таким значением литеры кода базе данных уже существует!',
                                                  'Некорректные данные',MB_ICONINFORMATION);
                          if edtCodeLiter.CanFocus then edtCodeLiter.SetFocus;
                          Exit;
                        end;
                      end;
                  end;

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
                if ChildTreeExists(edtPriceName.Text)
                then
                  begin
                    Application.MessageBox(PChar(ChildPriceItemListExixst),'Некорректные данные',MB_ICONINFORMATION);
                    if edtPriceName.CanFocus then edtPriceName.SetFocus;
                    Exit;
                  end
                else
                  begin
                    if IsPickedNode
                    then
                      begin
                        if (CompareText(InitPriceItemValue,Trim(edtPriceName.Text), loUserLocale) <> 0) then
                          if mds_baseprice.Locate('BASEPRICE_PROC_NAME',Trim(edtPriceName.Text),[loCaseInsensitive]) then
                          begin
                            Application.MessageBox(PChar(ChildPriceItemBaseExixst),'Некорректные данные',MB_ICONINFORMATION);
                            if edtPriceName.CanFocus then edtPriceName.SetFocus;
                            Exit;
                          end;
                      end
                    else
                      if mds_baseprice.Locate('BASEPRICE_PROC_NAME',Trim(edtPriceName.Text),[loCaseInsensitive]) then
                      begin
                        Application.MessageBox(PChar(ChildPriceItemBaseExixst),'Некорректные данные',MB_ICONINFORMATION);
                        if edtPriceName.CanFocus then edtPriceName.SetFocus;
                        Exit;
                      end;
                  end;

                if not Assigned(NodeSender) then Exit;
                NodeLvl:= vst.GetNodeLevel(NodeSender);

                case NodeLvl of
                  0: Node:= vst.InsertNode(NodeSender, amAddChildFirst);
                  1: Node:= vst.InsertNode(NodeSender, amInsertAfter);
                end;
              end;
    ansNodeEdit:
              begin
                NodeLvl:= vst.GetNodeLevel(NodeSender);
                Data:= vst.GetNodeData(NodeSender);

                case NodeLvl of
                  0:
                    begin
                      if (CompareText(InitPriceItemValue, Format('%s~%s',
                                      [Trim(edtPriceName.Text),Trim(edtCodeLiter.Text)]),loUserLocale) <> 0) then
                        if RootTreeExists(edtPriceName.Text)
                        then
                          begin
                            Application.MessageBox(PChar(RootPriceItemListExixst),'Некорректные данные',MB_ICONINFORMATION);
                            if edtPriceName.CanFocus then edtPriceName.SetFocus;
                            Exit;
                          end
                        else
                          begin
                            if mds_laborissue.Locate('LABORISSUE_NAME',Trim(edtPriceName.Text),[loCaseInsensitive]) then
                            begin
                              Application.MessageBox(PChar(RootPriceItemBaseExixst),
                                                      'Некорректные данные',MB_ICONINFORMATION);
                              if edtPriceName.CanFocus then edtPriceName.SetFocus;
                              Exit;
                            end;

                            if mds_laborissue.Locate('LABORISSUE_CODELITER',Trim(edtCodeLiter.Text),[loCaseInsensitive]) then
                            begin
                              Application.MessageBox('Раздел с таким значением литеры кода базе данных уже существует!',
                                                      'Некорректные данные',MB_ICONINFORMATION);
                              if edtCodeLiter.CanFocus then edtCodeLiter.SetFocus;
                              Exit;
                            end;
                          end;
                    end;
                  1:
                    begin
                      if (CompareText(InitPriceItemValue, Trim(edtPriceName.Text),loUserLocale) <> 0) then
                        if ChildTreeExists(edtPriceName.Text)
                        then
                          begin
                            Application.MessageBox(PChar(ChildPriceItemListExixst),'Некорректные данные',MB_ICONINFORMATION);
                            if edtPriceName.CanFocus then edtPriceName.SetFocus;
                            Exit;
                          end
                        else
                          begin
                            if mds_baseprice.Locate('BASEPRICE_PROC_NAME',Trim(edtPriceName.Text),[loCaseInsensitive]) then
                            begin
                              Application.MessageBox(PChar(ChildPriceItemBaseExixst),'Некорректные данные',MB_ICONINFORMATION);
                              if edtPriceName.CanFocus then edtPriceName.SetFocus;
                              Exit;
                            end;
                          end;

                    end;
                end;

                Node:= NodeSender;
              end;

  end;

  Data:= vst.GetNodeData(Node);

  if Assigned(Data) then
  begin
    NodeLvl:= vst.GetNodeLevel(Node);

    case ActionNodeSender of
      ansNodeRoot:
        begin
          Data^.PriceID:= 0;
          Data^.DepartID:= 0;
          Data^.ItemName:= Trim(edtPriceName.Text);
          Data^.CurrentChangeType:= tctInserted;
          Data^.LastChangeType:= Data^.CurrentChangeType;

          if mds_laborissue.Locate('LABORISSUE_NAME',Trim(edtPriceName.Text),[loCaseInsensitive])
            then Data^.ExistStatus:= tctExisting
            else Data^.ExistStatus:= tctNew;
        end;
      ansNodeChild:
        begin
          Data^.PriceID:= 0;
          Data^.DepartID:= 0;
          Data^.ItemName:= Trim(edtPriceName.Text);
          Data^.CurrentChangeType:= tctInserted;
          Data^.LastChangeType:= Data^.CurrentChangeType;

          if mds_baseprice.Locate('BASEPRICE_PROC_NAME',Trim(edtPriceName.Text),[loCaseInsensitive])
            then Data^.ExistStatus:= tctExisting
            else Data^.ExistStatus:= tctNew;
        end;
      ansNodeEdit:
        begin
          Data^.CurrentChangeType:= tctUpdated;
          Data^.LastChangeType:= Data^.CurrentChangeType;
          Data^.ItemName:= Trim(edtPriceName.Text);
        end;
    end;

    case NodeLvl of
    0:
      begin
        Data^.CurrentCost:= 0;
        Data^.InitCost:= 0;
        Data^.CodeLiter:= UpperCase(Trim(edtCodeLiter.Text),loUserLocale);
      end;
    1:
      begin
        fs:= TFormatSettings.Create;
        if TryStrToCurr(edtPriceCost.Text, tmpCurr,fs) then Data^.CurrentCost:= tmpCurr;
        Data^.CodeLiter:= '';
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

  chbHideDelNodeClick(Sender);
//  if vst.CanFocus then vst.SetFocus;
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

  FActionNodeSender:= ansNodeEdit;

  Data:= vst.GetNodeData(NodeSender);
  if not Assigned(Data) then Exit;


  edtPriceName.Text:= Data^.ItemName;
  NodeLvl:= vst.GetNodeLevel(NodeSender);

  case NodeLvl of
    0:
      begin
        if (Data^.CurrentChangeType <> tctExisting)
          then edtCodeLiter.Text:= UpperCase(Data^.CodeLiter, loUserLocale);

        FInitPriceItemValue:= UpperCase(Format('%s~%s',[Data^.ItemName,Data^.CodeLiter]),loUserLocale);
      end;
    1:
      begin
        fs:= TFormatSettings.Create;
        edtPriceCost.Text:= Format('%2.2f',[Data^.CurrentCost]);
        FInitPriceItemValue:= UpperCase(Data^.ItemName, loUserLocale);
      end;
  end;

  actEdtNodeDataOnExecute(Sender);
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
  chbHideDelNodeClick(Sender);

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

  pnlEdtCost.Visible:= True;
  pnlEdtCodeLiter.Visible:= not pnlEdtCost.Visible;

  FNodeSender:= vst.GetFirstSelected;

//  NodeLvl:= vst.GetNodeLevel(NodeSender);
//  pnlEdtCost.Visible:= (NodeLvl = 1);
//  pnlEdtCodeLiter.Visible:= (NodeLvl <> 1);

  FActionNodeSender:= ansNodeChild;
  actEdtNodeDataOnExecute(Sender);

  edtPriceName.Clear;
  edtCodeLiter.Clear;
  edtPriceCost.Text:= '0';

  if TryStrToCurr(edtPriceCost.Text, tmpCurr,fs)
    then edtPriceCost.Text:= Format('%2.2f',[tmpCurr])
    else edtPriceCost.Clear;

  if edtPriceName.CanFocus then edtPriceName.SetFocus;
end;

procedure TForm1.actPriceAddExecute(Sender: TObject);
begin
  EditMode:= emAdd;
//  PriceName:= '';
  cbbPriceChange(Sender);
  actPriceFillExecute(Sender);
  actTreeShowOnExecute(Sender);
end;

procedure TForm1.actPriceCancelExecute(Sender: TObject);
begin
  actTreeShowOffExecute(Sender);
end;

procedure TForm1.actPriceDelExecute(Sender: TObject);
begin
//  if mds_laborissue.IsEmpty then Exit;

  try
    tmpTrans.StartTransaction;
    tmpQry.Close;
    tmpQry.SQL.Text:= SQLTextTblPriceDelete;
    tmpQry.Prepare;
    tmpQry.ParamByName('NAME_PRICE').Value:= cbbPrice.Items[cbbPrice.ItemIndex];
    tmpQry.ExecQuery;

    tmpTrans.Commit;

    FillCbbPrice(Sender);
    cbbPriceChange(Sender);
  except
    on E: EFIBError do
    begin
      tmpTrans.Rollback;
      Application.MessageBox(PChar(E.Message), 'Ошибка удаления данных', MB_ICONERROR);
    end;
  end;
end;

procedure TForm1.actPriceEdtExecute(Sender: TObject);
begin
  EditMode:= emEdit;
//  PriceName:= cbbPrice.Items[cbbPrice.ItemIndex];
  cbbPriceChange(Sender);
  actPriceFillExecute(Sender);
  actTreeShowOnExecute(Sender);
end;

procedure TForm1.actPriceFillExecute(Sender: TObject);
var
  Node, ChdNode: PVirtualNode;
  Data: PMyRec;
  NodeID: integer;//ID of current Node
  RootID: Integer;//parent ID of current Node

begin
  NodeID:= -1;
  RootID:= -1;
  if not mds_common.Active then Exit;

  if mds_laborissue.Active
    then mds_laborissue.EmptyTable
    else mds_laborissue.Active:= True;

  if mds_baseprice.Active
    then mds_baseprice.EmptyTable
    else mds_baseprice.Active:= True;

  try
    vst.BeginUpdate;
    vst.Clear;

//    mds_common.DisableControls;

    try
      tmpTrans.StartTransaction;

      tmpQry.Close;
      tmpQry.SQL.Text:= SQLTextTblLaborIssueSelect;
      tmpQry.ExecQuery;

      while not tmpQry.Eof do
      begin
        mds_laborissue.AppendRecord([
                  tmpQry.FieldByName('LABORISSUE_ID').AsInteger,
                  tmpQry.FieldByName('LABORISSUE_NAME').AsString,
                  tmpQry.FieldByName('LABORISSUE_CODELITER').AsString
                            ]);
        tmpQry.Next;
      end;

      tmpQry.Close;
      tmpQry.SQL.Text:= SQLTextTblBasepriceSelect;
      tmpQry.ExecQuery;

      while not tmpQry.Eof do
      begin
        mds_baseprice.AppendRecord([
          tmpQry.FieldByName('BASEPRICE_ID').AsInteger,
          tmpQry.FieldByName('BASEPRICE_PROC_CODE').AsString,
          tmpQry.FieldByName('BASEPRICE_PROC_NAME').AsString,
          tmpQry.FieldByName('BASEPRICE_PROC_ISSUE_FK').AsInteger
                                    ]);
        tmpQry.Next;
      end;

      tmpTrans.Commit;
    except
      on E: EFIBError do
      begin
        tmpTrans.Rollback;
        Application.MessageBox(PChar(E.Message), 'Ошибка доступа к данным', MB_ICONERROR);
      end;
    end;

    mds_laborissue.First;

    while not mds_laborissue.Eof do
    begin
      mds_src.Filtered:= False;
      mds_src.Filter:= Format('(UPPER(NAME_PRICE) LIKE UPPER(''%%%s%%'')) AND (LABORISSUE_ID=%d)',
                                    [PriceName,mds_laborissue.FieldByName('LABORISSUE_ID').AsInteger]);
      mds_src.Filtered:= True;

      if not mds_src.IsEmpty then
      begin
        mds_src.First;

        Node:= vst.AddChild(nil);
        Data:= vst.GetNodeData(Node);
        NodeID:= 0;
        RootID:= 0;
        FTreeChangeType:= tctExisting;


        if Assigned(Data) then
        begin
          Data^.PriceID:= NodeID;
          Data^.DepartID:= RootID;
          Data^.CurrentChangeType:= TreeChangeType;
          Data^.LastChangeType:= TreeChangeType;
          Data^.ExistStatus:= TreeChangeType;
          Data^.ItemName:= mds_src.FieldByName('LABORISSUE_NAME').AsString;
          Data^.CurrentCost:= 0;
          Data^.InitCost:= 0;
          Data^.CodeLiter:= mds_src.FieldByName('LABORISSUE_CODELITER').AsString;

//          RootID:= NodeID;

          while not mds_src.Eof do
          begin
            ChdNode:= vst.AddChild(Node);
            Data:= vst.GetNodeData(ChdNode);

//            case EditMode of
//              emAdd: NodeID:= vst.AbsoluteIndex(ChdNode);
//              emEdit: NodeID:= mds_src.FieldByName('BASEPRICE_ID').AsInteger;
//            end;

            if Assigned(Data) then
            begin
              Data^.PriceID:= NodeID;
              Data^.DepartID:= RootID;
              Data^.CurrentChangeType:= TreeChangeType;
              Data^.LastChangeType:= TreeChangeType;
              Data^.ExistStatus:= TreeChangeType;
              Data^.ItemName:= mds_src.FieldByName('BASEPRICE_PROC_NAME').AsString;
              Data^.CurrentCost:= mds_src.FieldByName('COST_PROC_PRICE').AsCurrency;
              Data^.InitCost:= mds_src.FieldByName('COST_PROC_PRICE').AsCurrency;
              Data^.CodeLiter:= '';
            end;

            mds_src.Next;
          end;

        end;{Assigned(Data) of Node}
      end; {not mds_src.IsEmpty}

      mds_laborissue.Next;
    end;
  finally

    mds_src.Filtered:= False;
//    mds_src.Filter:= Format('UPPER(NAME_PRICE) LIKE UPPER(''%%%s%%'')',[PriceName]);
//    mds_src.Filtered:= True;

//    mds_src.EnableControls;
    vst.EndUpdate;
  end;
end;

procedure TForm1.actPriceSaveExecute(Sender: TObject);
var
  rNode, chNode: PVirtualNode;
  Data: PMyRec;
  laborissue_id, baseprice_id: Integer;
begin
  if (vst.RootNodeCount = 0) then Exit;

  rNode:= nil;
  chNode:= nil;
  laborissue_id:= -1;
  baseprice_id:= -1;

  if (EditMode = emAdd) then
    if (Trim(edtSetPriceName.Text) = '') then
    begin
      Application.MessageBox('Задайте имя прайс-листа!','Некорректные данные',MB_ICONINFORMATION);
      if edtSetPriceName.CanFocus then edtSetPriceName.SetFocus;
      Exit;
    end;

  try
    tmpTrans.StartTransaction;

    //==== getting a list of price names into mds_price ====//
    tmpQry.Close;
    tmpQry.SQL.Text:= SQLTextTblPriceSelect;
    tmpQry.ExecQuery;

    if mds_price.Active
      then mds_price.EmptyTable
      else mds_price.Active:= True;

    while not tmpQry.Eof do
    begin
      mds_price.AppendRecord([
                tmpQry.FieldByName('ID_PRICE').AsInteger,
                tmpQry.FieldByName('NAME_PRICE').AsString
                              ]);
      tmpQry.Next;
    end;

    tmpTrans.Commit;
  except
    on E: EFIBError do
    begin
      tmpTrans.Rollback;
      Application.MessageBox(PChar(E.Message), 'Ошибка доступа к данным', MB_ICONERROR);
      Exit;
    end;
  end;

  if (EditMode = emAdd) then
  begin
    if mds_price.Locate('NAME_PRICE', Trim(edtSetPriceName.Text),[loCaseInsensitive]) then
    begin
      Application.MessageBox('Такое имя прайс-листа уже есть в базе данных. Задайте другое!','Некорректные данные',MB_ICONINFORMATION);
      if edtSetPriceName.CanFocus then edtSetPriceName.SetFocus;
      Exit;
    end;

    PriceName:= Trim(edtSetPriceName.Text);
  end;

  try
    //==== getting a list of laboratory sections into mds_laborissue ====//
    tmpTrans.StartTransaction;
    tmpQry.Close;
    tmpQry.SQL.Text:= SQLTextTblLaborIssueSelect;
    tmpQry.ExecQuery;

    if mds_laborissue.Active
      then mds_laborissue.EmptyTable
      else mds_laborissue.Active:= True;

    while not tmpQry.Eof do
    begin
      mds_laborissue.AppendRecord([
        tmpQry.FieldByName('LABORISSUE_ID').AsInteger,
        tmpQry.FieldByName('LABORISSUE_NAME').AsString,
        tmpQry.FieldByName('LABORISSUE_CODELITER').AsString
                                  ]);
      tmpQry.Next;
    end;

    //==== getting a list of the basic price items into mds_baseprice  ====//
    tmpQry.Close;
    tmpQry.SQL.Text:= SQLTextTblBasepriceSelect;
    tmpQry.ExecQuery;

    if mds_baseprice.Active
      then mds_baseprice.EmptyTable
      else mds_baseprice.Active:= True;

    while not tmpQry.Eof do
    begin
      mds_baseprice.AppendRecord([
        tmpQry.FieldByName('BASEPRICE_ID').AsInteger,
        tmpQry.FieldByName('BASEPRICE_PROC_CODE').AsString,
        tmpQry.FieldByName('BASEPRICE_PROC_NAME').AsString,
        tmpQry.FieldByName('BASEPRICE_PROC_ISSUE_FK').AsInteger
                                  ]);
      tmpQry.Next;
    end;

    tmpTrans.Commit;
  except
      on E: EFIBError do
      begin
        tmpTrans.Rollback;
        Application.MessageBox(PChar(E.Message), 'Ошибка доступа к данным', MB_ICONERROR);
        Exit;
      end;
  end;

  //adding the missing entries in the laborissue and baseprice tables
  try
    tmpTrans.StartTransaction;
    qryLaborissue.Close;
    qryLaborissue.SQL.Text:= SQLTextTblLaborIssueInsert;
    qryLaborissue.Prepare;

    qryBaseprice.Close;
    qryBaseprice.SQL.Text:= SQLTextTblBasepriceInsert;
    qryBaseprice.Prepare;

    rNode:= vst.GetFirst;

    while Assigned(rNode) do
    begin
      Data:= vst.GetNodeData(rNode);
      if Assigned(Data) then
      begin
        if mds_laborissue.Locate('LABORISSUE_NAME', Data^.ItemName,[loCaseInsensitive])
        then
          laborissue_id:= mds_laborissue.FieldByName('LABORISSUE_ID').AsInteger
        else
          begin
            qryLaborissue.ParamByName('LABORISSUE_NAME').Value:= Data^.ItemName;
            qryLaborissue.ParamByName('LABORISSUE_CODELITER').Value:= Data^.CodeLiter;
            qryLaborissue.ExecQuery;
            laborissue_id:= qryLaborissue.FieldByName('LABORISSUE_ID').AsInteger;
          end;

        Data^.PriceID:= laborissue_id;
        Data^.DepartID:= 0;
      end;

      if (vsHasChildren in rNode.States) then
      begin
        chNode:= rNode^.FirstChild;

        while Assigned(chNode) do
        begin
          Data:= vst.GetNodeData(chNode);

          if Assigned(Data) then
          begin
            if mds_baseprice.Locate('BASEPRICE_PROC_NAME',Data^.ItemName,[loCaseInsensitive])
            then
              baseprice_id:= mds_baseprice.FieldByName('BASEPRICE_ID').AsInteger
            else
              begin
                qryBaseprice.ParamByName('BASEPRICE_PROC_NAME').Value:= Data^.ItemName;
                qryBaseprice.ParamByName('BASEPRICE_PROC_ISSUE_FK').Value:= laborissue_id;
                qryBaseprice.ExecQuery;
                baseprice_id:= qryBaseprice.FieldByName('BASEPRICE_ID').AsInteger;
              end;
            Data^.PriceID:= baseprice_id;
            Data^.DepartID:= laborissue_id;
          end;

          chNode:= chNode.NextSibling;
        end;
      end;

      rNode:= rNode.NextSibling;
    end;

    //create new/update an existing price list
    qryPriceItemInsert.Close;
    qryPriceItemInsert.SQL.Text:= SQLTextTblPriceItemInsert;
    qryPriceItemInsert.Prepare;

    qryPriceItemUpdate.Close;
    qryPriceItemUpdate.SQL.Text:= SQLTextTblPriceItemUpdate;
    qryPriceItemUpdate.Prepare;

    qryPriceItemDelete.Close;
    qryPriceItemDelete.SQL.Text:= SQLTextTblPriceItemDelete;
    qryPriceItemDelete.Prepare;

    rNode:= vst.GetFirst;

    case EditMode of
      emAdd:
        begin
          while Assigned(rNode) do
          begin
            Data:= vst.GetNodeData(rNode);
            if Assigned(Data) then
              if (Data^.CurrentChangeType <> tctDeleted) then
                if (vsHasChildren in rNode.States) then
                begin
                  chNode:= rNode^.FirstChild;

                  while Assigned(chNode) do
                  begin
                    Data:= vst.GetNodeData(chNode);

                    if Assigned(Data) then
                      if (Data^.CurrentChangeType <> tctDeleted) then
                      begin
                        qryPriceItemInsert.ParamByName('FK_BASEPRICE').Value:= Data^.PriceID;
                        qryPriceItemInsert.ParamByName('NAME_PRICE').Value:= PriceName;
                        qryPriceItemInsert.ParamByName('COST_PROC_PRICE').Value:= Data^.CurrentCost;
                        qryPriceItemInsert.ExecQuery;
                      end;

                    chNode:= chNode.NextSibling;
                  end;
                end;
            rNode:= rNode.NextSibling;
          end;
        end;
      emEdit:
        begin
          while Assigned(rNode) do
          begin
            if (vsHasChildren in rNode.States) then
            begin
              chNode:= rNode^.FirstChild;

              while Assigned(chNode) do
              begin
                Data:= vst.GetNodeData(chNode);

                if Assigned(Data) then
                  case Data^.CurrentChangeType of
                    tctInserted:
                          begin
                            qryPriceItemInsert.ParamByName('FK_BASEPRICE').Value:= Data^.PriceID;
                            qryPriceItemInsert.ParamByName('NAME_PRICE').Value:= PriceName;
                            qryPriceItemInsert.ParamByName('COST_PROC_PRICE').Value:= Data^.CurrentCost;
                            qryPriceItemInsert.ExecQuery;
                          end;
                     tctUpdated:
                          case Data^.ExistStatus of
                                 tctNew:
                                    begin
                                      qryPriceItemInsert.ParamByName('FK_BASEPRICE').Value:= Data^.PriceID;
                                      qryPriceItemInsert.ParamByName('NAME_PRICE').Value:= PriceName;
                                      qryPriceItemInsert.ParamByName('COST_PROC_PRICE').Value:= Data^.CurrentCost;
                                      qryPriceItemInsert.ExecQuery;
                                    end;
                            tctExisting:
                                    begin
                                      qryPriceItemUpdate.ParamByName('COST_PROC_PRICE').Value:= Data^.CurrentCost;
                                      qryPriceItemUpdate.ParamByName('FK_BASEPRICE').Value:= Data^.PriceID;
                                      qryPriceItemUpdate.ParamByName('NAME_PRICE').Value:= PriceName;
                                      qryPriceItemUpdate.ExecQuery;
                                    end;
                          end;
                     tctDeleted:
                          begin
                            qryPriceItemDelete.ParamByName('FK_BASEPRICE').Value:= Data^.PriceID;
                            qryPriceItemDelete.ParamByName('NAME_PRICE').Value:= PriceName;
                            qryPriceItemDelete.ExecQuery;
                          end;
                  end;
                chNode:= chNode.NextSibling;
              end;
            end;
            rNode:= rNode.NextSibling;
          end;
        end;
    end;

    tmpTrans.Commit;
  except
    on E: EFIBError do
    begin
      tmpTrans.Rollback;
      Application.MessageBox(PChar(E.Message), 'Ошибка модификации данных', MB_ICONERROR);
      Exit;
    end;
  end;

  actGetCommonDataExecute(Sender);
  FillCbbPrice(Sender);
  actSetPriceFilterExecute(Sender);
  actTreeShowOffExecute(Sender);
end;

procedure TForm1.cbbPriceChange(Sender: TObject);
begin
  FPriceName:= cbbPrice.Items[cbbPrice.ItemIndex];
  actSetPriceFilterExecute(Sender);
end;

procedure TForm1.chbSetZeroCostClick(Sender: TObject);
var
  rNode, chNode: PVirtualNode;
  Data: PMyRec;
begin
  if (vst.TotalCount = 0) then Exit;
  if (EditMode = emEdit) then Exit;

  rNode:= vst.GetFirst;

  while Assigned(rNode) do
  begin
    if (vsHasChildren in rNode^.States) then
    begin
      chNode:= vst.GetFirstChild(rNode);

      while Assigned(chNode) do
      begin
        Data:= vst.GetNodeData(chNode);

        if Assigned(Data) then
        begin
          if chbSetZeroCost.Checked
            then Data^.CurrentCost:= 0
            else Data^.CurrentCost:= Data^.InitCost;
        end;
        chNode:= chNode.NextSibling;
      end;
    end;
    rNode:= rNode.NextSibling;
  end;

  vst.Refresh;

end;

procedure TForm1.chbShowUpdatedPriceClick(Sender: TObject);
begin
  vst.Refresh;
end;

procedure TForm1.chbHideDelNodeClick(Sender: TObject);
var
  rNode, chNode, lsNode: PVirtualNode;
  Data: PMyRec;
begin
  if (vst.RootNodeCount = 0) then Exit;

  try
    vst.BeginUpdate;

    if (vst.SelectedCount > 0)
      then lsNode:= vst.GetFirstSelected
      else lsNode:= vst.GetFirst;

    rNode:= vst.GetFirst;

    while Assigned(rNode) do
    begin
      Data:= vst.GetNodeData(rNode);
      if Assigned(Data) then
      begin
        if (Data^.CurrentChangeType = tctDeleted)
        then
          vst.IsVisible[rNode]:= not chbHideDelNode.Checked
        else
          begin
            if (rNode^.ChildCount > 0) then
            begin
              chNode:= rNode^.FirstChild;

              while Assigned(chNode) do
              begin
                Data:= vst.GetNodeData(chNode);

                if Assigned(Data) then
                  if (Data^.CurrentChangeType = tctDeleted) then vst.IsVisible[chNode]:= not chbHideDelNode.Checked;
                chNode:= chNode.NextSibling;
              end;
            end;
          end;
      end;

      rNode:= rNode.NextSibling;
    end;
    vst.Refresh;
    if vst.CanFocus then vst.SetFocus;

    if Assigned(vst.TopNode) then //visible node count > 0
      if (chbHideDelNode.Checked and not (vsVisible in lsNode.States)) then
      begin
        vst.ClearSelection;

        if (vsHasChildren in lsNode.States)
          then lsNode:= vst.GetFirstVisible(nil,True,False)
          else lsNode:= vst.GetFirstVisible(lsNode.Parent,True,False);

        vst.Selected[lsNode]:= True;
      end;

   ActChkStatusBtnExecute(Sender);
  finally
    vst.EndUpdate;
  end;
end;

procedure TForm1.edtCodeLiterKeyPress(Sender: TObject; var Key: Char);
begin
//  if not (Key in ['A'..'Z','a'..'z']) then Key:= #0;
  if not CharInSet(Key,['A'..'Z','a'..'z']) then Key:= #0;
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
//  if not (Key in ['0'..'9','-',fs.DecimalSeparator]) then Key:= #0;
  if not CharInSet(Key,['0'..'9','-',fs.DecimalSeparator]) then Key:= #0;
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
  FInitPriceItemValue:= '';
  FIsPickedNode:= False;
  FTreeChangeType:= tctInserted;
  FNodeSender:= nil;
  EditMode:= emAdd;
  edtPriceName.MaxLength:= 100;
  edtCodeLiter.MaxLength:= 5;
  pnlTbl.Align:= alClient;

  with vst do
  begin
    //vst properties
    hintmode:= hmTooltip;
    ShowHint:= True;

    TreeOptions.AutoOptions:= TreeOptions.AutoOptions
              + []
              - [toAutoDeleteMovedNodes]
              ;

    TreeOptions.MiscOptions:= TreeOptions.MiscOptions
              + []
              - [toToggleOnDblClick, toEditOnClick]
              ;

    TreeOptions.SelectionOptions:= TreeOptions.SelectionOptions
              + [toExtendedFocus, toFullRowSelect, toLevelSelectConstraint, toMultiSelect,
                 toSiblingSelectConstraint, toAlwaysSelectNode]
              - []
              ;

    OnAddToSelection:= vstAddToSelection;
    OnCollapsed:= vstCollapsed;
    OnDragDrop:= vstDragDrop;
    OnDragOver:= vstDragOver;
    OnEditing:= vstEditing;
    OnExpanded:= vstExpanded;
    OnFreeNode:= vstFreeNode;
    OnGetNodeDataSize:= vstGetNodeDataSize;
    OnGetText:= vstGetText;
    OnHeaderDraw:= vstHeaderDraw;
//    OnHeaderDrawQueryElements:= vstHeaderDrawQueryElements;
//    OnAdvancedHeaderDraw:= vstAdvancedHeaderDraw;
//    OnInitNode:= vstInitNode;
//    OnKeyPress:= vstKeyPress;
//    OnNewText:= vstNewText;
    OnPaintText:= vstPaintText;
    OnRemoveFromSelection:= vstRemoveFromSelection;

    PopupMenu:= ppmVST;


    //header properties
    with Header do
    begin
      Columns.Clear;
      Columns.Add;
      Columns[0].Text:= 'Название';

      Columns.Add;
      Columns[1].Text:= 'Стоимость';

      AutoSizeIndex:= 0;
      Height:= 30;
      Options:= Options + [hoAutoResize, hoOwnerDraw, hoShowHint
                          , hoShowImages,hoVisible, hoAutoSpring];

      for i := 0 to Pred(Columns.Count) do
      begin
        Columns.Items[i].Style:= vsOwnerDraw;
        Columns.Items[i].CaptionAlignment:= taCenter;
        if (Columns.Items[i].Position = 1) then Columns.Items[i].Width:= 100;
      end;
    end;

  end;


  with mds_baseprice do
  begin
    FieldDefs.Add('BASEPRICE_ID', ftInteger);
    FieldDefs.Add('BASEPRICE_PROC_CODE', ftString, 20);
    FieldDefs.Add('BASEPRICE_PROC_NAME', ftString, 100);
    FieldDefs.Add('BASEPRICE_PROC_ISSUE_FK', ftInteger);

    CreateDataSet;
    Filtered:= False;
    Active := False;
  end;

  with mds_price do
  begin
    FieldDefs.Add('ID_PRICE', ftInteger);
    FieldDefs.Add('NAME_PRICE', ftString, 40);

    CreateDataSet;
    Filtered:= False;
    Active := False;
  end;

  with mds_common do
  begin
    FieldDefs.Add('BASEPRICE_ID', ftInteger);
    FieldDefs.Add('BASEPRICE_PROC_NAME', ftString, 100);
    FieldDefs.Add('COST_PROC_PRICE', ftCurrency);
    FieldDefs.Add('LABORISSUE_ID', ftInteger);
    FieldDefs.Add('LABORISSUE_NAME', ftString, 100);
    FieldDefs.Add('LABORISSUE_CODELITER', ftString, 5);
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
    FieldDefs.Add('LABORISSUE_CODELITER', ftString, 5);
    FieldDefs.Add('NAME_PRICE', ftString,40);

    CreateDataSet;
    Filtered:= False;
    Active := False;
  end;

  with mds_laborissue do
  begin
    FieldDefs.Add('LABORISSUE_ID', ftInteger);
    FieldDefs.Add('LABORISSUE_NAME', ftString, 100);
    FieldDefs.Add('LABORISSUE_CODELITER', ftString, 5);

    CreateDataSet;
    Filtered:= False;
    Active := False;
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  tmpDB.Connected:= True;

  actGetCommonDataExecute(Sender);

  try
    mds_common.DisableControls;

//    try

//      tmpTrans.StartTransaction;
//
//      with tmpQry do
//      begin
//        Close;
//        SQL.Text:= SQLTextResultSelect;
//        ExecQuery;
//
//        while not Eof do
//        begin
//             mds_common.AppendRecord([
//                  FieldByName('BASEPRICE_ID').AsInteger,
//                  FieldByName('BASEPRICE_PROC_NAME').AsString,
//                  FieldByName('COST_PROC_PRICE').AsCurrency,
//                  FieldByName('LABORISSUE_ID').AsInteger,
//                  FieldByName('LABORISSUE_NAME').AsString,
//                  FieldByName('LABORISSUE_CODELITER').AsString,
//                  FieldByName('NAME_PRICE').AsString
//                                ]);
//
//             mds_src.AppendRecord([
//                  FieldByName('BASEPRICE_ID').AsInteger,
//                  FieldByName('BASEPRICE_PROC_NAME').AsString,
//                  FieldByName('COST_PROC_PRICE').AsCurrency,
//                  FieldByName('LABORISSUE_ID').AsInteger,
//                  FieldByName('LABORISSUE_NAME').AsString,
//                  FieldByName('LABORISSUE_CODELITER').AsString,
//                  FieldByName('NAME_PRICE').AsString
//                                ]);
//          Next;
//        end;
//      end;
//      tmpTrans.Commit;
//
//      mds_common.First;
      FillCbbPrice(Sender);
      cbbPriceChange(Sender);
      actTreeShowOffExecute(Sender);
//    except
//      on E: EFIBError do
//      begin
//        tmpTrans.Rollback;
//        Application.MessageBox(PChar(E.Message), 'Ошибка доступа к данным', MB_ICONERROR);
//      end;
//    end;
  finally
    mds_common.EnableControls;
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
//    FTreeChangeType:= Data.CurrentChangeType;

    case Data^.CurrentChangeType of
      tctExisting: ss:= 'tctExisting';
      tctDeleted: ss:= 'tctDeleted';
      tctInserted: ss:= 'tctInserted';
      tctUpdated: ss:= 'tctUpdated';
      tctNew: ss:= 'tctNew';
    end;

    case Data^.ExistStatus of
      tctExisting: ss1:= 'tctExisting';
      tctDeleted: ss1:= 'tctDeleted';
      tctInserted: ss1:= 'tctInserted';
      tctUpdated: ss1:= 'tctUpdated';
      tctNew: ss1:= 'tctNew';
    end;

    Self.Caption:= Format('PriceID: %d | DepartID: %d |  PriceName: %s | CurrentChangeType: %s | ExistStatus: %s | ',[
      Data^.PriceID,
      Data^.DepartID,
      Data^.ItemName,
      ss,
      ss1
                            ]);
  end;

  ActChkStatusBtnExecute(Sender);
  ActChkStatusMnuVSTExecute(Sender);
end;

procedure TForm1.vstAdvancedHeaderDraw(Sender: TVTHeader; var PaintInfo: THeaderPaintInfo;
  const Elements: THeaderPaintElements);
var
  R, //current rectangle
  cR, //rectangle-container
  exR: TRect;//rectangle above verticalscroll element
  i: Integer;
  w: integer;//width of verticalscroll element
  cp: TPoint;//center of current rectangle
  txt: string;//caption text
  te: TSize;//canvas text extend
begin
  Exit;
  //Header.Options = Header.Options + [hoOwnerDraw];
  if (hpeBackground in Elements) then
  begin
    cR:= PaintInfo.PaintRectangle;
    if Assigned(PaintInfo.Column)
    then
      begin
        for i := 0 to Pred(Sender.Columns.Count) do
          if (PaintInfo.Column = Sender.Columns.Items[i]) then
          begin
            R:= PaintInfo.PaintRectangle;
            if (i = Pred(Sender.Columns.Count)) then cR:= PaintInfo.PaintRectangle;
            R.Inflate(1,1,0,0);

            PaintInfo.TargetCanvas.Brush.Color:= clBtnFace;
            PaintInfo.TargetCanvas.FillRect(R);
            PaintInfo.TargetCanvas.Brush.Color:= vst.Colors.TreeLineColor;
            PaintInfo.TargetCanvas.FrameRect(R);

            //Sender.Columns.Items[i].Style = vsOwnerDraw
            PaintInfo.TargetCanvas.Brush.Color:= clBtnFace;
            PaintInfo.TargetCanvas.Font.Color:= clHotLight;

            cp:= R.CenterPoint;
            txt:= Sender.Columns.Items[i].Text;
            te:= PaintInfo.TargetCanvas.TextExtent(txt);
            PaintInfo.TargetCanvas.TextOut(cp.X - te.cx div 2, cp.Y - te.cy div 2, txt);
          end;
      end
    else
      begin
        w:= GetSystemMetrics(SM_CYVTHUMB);
        exR:= Rect(cR.Right,cR.Top,cR.Right + w,cR.Bottom);
        PaintInfo.TargetCanvas.Brush.Color:= clRed;
        PaintInfo.TargetCanvas.FillRect(exR);
        PaintInfo.TargetCanvas.Brush.Color:= vst.Colors.TreeLineColor;
        PaintInfo.TargetCanvas.FrameRect(exR);
        Self.Caption:= Format('exR(%d,%d)(%d,%d) | R(%d,%d)(%d,%d)',[
              exR.Left,
              exR.Top,
              exR.Right,
              exR.Bottom,
              cR.Left,
              cR.Top,
              cR.Right,
              cR.Bottom

        ]);
      end;
  end;
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
//  pSource := TVirtualStringTree(Source).FocusedNode;
  DataTarget:= nil;
  DataSource:= nil;
  attMode:= amNoWhere;

  NodeTarget := Sender.DropTargetNode;
  Nodes:= TVirtualStringTree(Source).GetSortedSelection(True);
  if (System.Length(Nodes) = 0) then Exit;

  //allow dragging only those nodes that are not in the database
  for i := 0 to Pred(System.Length(Nodes)) do
  begin
    DataSource:= TVirtualStringTree(Source).GetNodeData(Nodes[i]);
    if Assigned(DataSource) then
      if (DataSource.ExistStatus = tctExisting) then
      begin
        Application.MessageBox('Можно перемещать только те добавленные данные, которых еще нет на текущий момент в базе данных.',
                              'Ошибка работы с данными', MB_ICONINFORMATION);
        Exit;
      end;
  end;

  case Mode of
    dmNowhere: attMode := amNoWhere;
    dmAbove:
      begin
        DataTarget:=Sender.GetNodeData(NodeTarget);
        Self.Caption:= Self.Caption + ' | ' + DataTarget^.ItemName + ' | index = ' + IntToStr(NodeTarget^.Index);
        NodeLvl:= Sender.GetNodeLevel(NodeTarget);

        case NodeLvl of
          0: attMode := amAddChildFirst;
          1: attMode := amInsertBefore;
        end;
      end;
    dmOnNode:
      begin
        DataTarget:=Sender.GetNodeData(NodeTarget);
        Self.Caption:= Self.Caption + ' | ' + DataTarget^.ItemName + ' | index = ' + IntToStr(NodeTarget^.Index);
        NodeLvl:= Sender.GetNodeLevel(NodeTarget);

        case NodeLvl of
          0: attMode := amAddChildFirst;
          1: attMode := amInsertAfter;
        end;
      end;
     dmBelow:
     begin
        DataTarget:=Sender.GetNodeData(NodeTarget);
        Self.Caption:= Self.Caption + ' | ' + DataTarget^.ItemName + ' | index = ' + IntToStr(NodeTarget^.Index);
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
        0: CellText:= Data^.ItemName;
        1: CellText:= '';
      end;
    1:
      case Column of
        0: CellText:= Data^.ItemName;
        1: CellText:= Format('%2.2f %s',[Data^.CurrentCost, fs.CurrencyString]);
      end;
  end;
end;

procedure TForm1.vstHeaderDraw(Sender: TVTHeader; HeaderCanvas: TCanvas; Column: TVirtualTreeColumn; R: TRect; Hover,
  Pressed: Boolean; DropMark: TVTDropMarkMode);
var
  i: integer;
  w: integer;//width of verticalscroll element
  cp: TPoint;//center of current rectangle
  txt: string;//caption text
  te: TSize;//canvas text extend
  exR, addR: TRect;
//  bm: TBitmap;
begin
//  try
//    bm:= TBitmap.Create;

    for i := 0 to Pred(Sender.Columns.Count) do
    begin
      if (Column = Sender.Columns.Items[i]) then
      begin
//        if (i = Pred(Sender.Columns.Count)) then exR:= R;

        R.Inflate(1,1,0,0);
        HeaderCanvas.Brush.Color:= clBtnFace;
        HeaderCanvas.FillRect(R);
        HeaderCanvas.Brush.Color:= vst.Colors.TreeLineColor;
        HeaderCanvas.FrameRect(R);

        HeaderCanvas.Brush.Color:= clBtnFace;
        HeaderCanvas.Font.Color:= clHotLight;

        cp:= R.CenterPoint;
        txt:= Sender.Columns.Items[i].Text;
        te:= HeaderCanvas.TextExtent(txt);
        HeaderCanvas.TextOut(cp.X - te.cx div 2, cp.Y - te.cy div 2, txt);
      end;
    end;

//    w:= GetSystemMetrics(SM_CYVTHUMB);
//    bm.Width:= w;
//    w:= (R.Bottom - R.Top);
//    bm.Height:= (R.Bottom - R.Top);
//
//    exR:= Rect(0,0,bm.Width,bm.Height);
//    exR:= Rect(R.Right,R.Top,bm.Width,bm.Height);
//    exR:= ClientToScreen(Rect(0,0,bm.Width,bm.Height));
//    bm.Canvas.Brush.Color:= clRed;
//    bm.Canvas.FillRect(exR);
//    bm.Canvas.Brush.Color:= vst.Colors.TreeLineColor;
//    bm.Canvas.FrameRect(exR);
//    vst.Canvas.Draw(R.Right + w,R.Top, bm);
//  finally
//    bm.Free;
//  end;
end;

procedure TForm1.vstHeaderDrawQueryElements(Sender: TVTHeader; var PaintInfo: THeaderPaintInfo;
  var Elements: THeaderPaintElements);
begin
  Exit;
  Elements:= [hpeBackground, hpeText];
end;

procedure TForm1.vstInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
begin
  Node.CheckType:= ctTriStateCheckBox;
end;

procedure TForm1.vstKeyPress(Sender: TObject; var Key: Char);
var
  Node: PVirtualNode;
  NodeLvl: Integer;
  fs: TFormatSettings;
begin
  Node:= vst.GetFirstSelected(True);
  NodeLvl:= vst.GetNodeLevel(Node);
  if ((NodeLvl = 1) and (vst.Header.Columns.ClickIndex = 1)) then
  begin
    fs:= TFormatSettings.Create;
//    if (Key in ['0'..'9']) then Key:= #0;
    if CharInSet(Key,['0'..'9']) then Key:= #0;

  end;
end;

procedure TForm1.vstNewText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; NewText: string);
var
  Data: PMyRec;
  NodeLvl: Integer;
  fs: TFormatSettings;
begin
  if (Trim(NewText) = '') then Exit;

  Data:= Sender.GetNodeData(Node);
  NodeLvl:= Sender.GetNodeLevel(Node);
  fs:= TFormatSettings.Create;

  case NodeLvl of
    0:
      case Column of
        0: Data^.ItemName:= NewText;
//        1: Exit;
      end;
    1:
      case Column of
        0: Data^.ItemName:= NewText;
        1:
          begin
            NewText:= StringReplace(NewText,'.',',',[rfReplaceAll, rfIgnoreCase]);
            Data^.CurrentCost:= StrToCurr(NewText, fs);
          end;
      end;
  end;
end;

procedure TForm1.vstPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType);
var
  Data: PMyRec;
begin
  Data:= Sender.GetNodeData(Node);

  if Assigned(Data) then
  begin
    if (Data^.CurrentChangeType = tctDeleted) then
    begin
      TargetCanvas.Font.Style:= TargetCanvas.Font.Style + [TFontStyle.fsStrikeOut];
      TargetCanvas.Font.Color:= clGrayText;
    end;

    if (EditMode = emEdit) then
      if chbShowUpdatedPrice.Checked then
        if (Data^.CurrentCost <> Data^.InitCost) then
          TargetCanvas.Font.Style:= TargetCanvas.Font.Style + [TFontStyle.fsBold];
  end;
end;

procedure TForm1.vstRemoveFromSelection(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  ActChkStatusBtnExecute(Sender);
end;

end.
