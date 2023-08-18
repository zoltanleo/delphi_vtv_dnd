unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, MemTableDataEh, Data.DB, MemTableEh, DBGridEhGrouping,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, FIBQuery, pFIBQuery, FIBDatabase, pFIBDatabase, EhLibVCL, GridsEh,
  DBAxisGridsEh, DBGridEh, fib, Vcl.ComCtrls
  , VirtualTrees, Vcl.ExtCtrls, System.Actions
  , Vcl.ActnList
  , Winapi.ActiveX
  ;

type

  PMyRec = ^TMyRec;
  TMyRec = record
    PriceID: Integer;
    LaborissueID: Integer;
    IsModified: Boolean;
    PriceName: string;
    PriceCost: Currency;
  end;

  TForm1 = class(TForm)
    tmpDB: TpFIBDatabase;
    tmpTrans: TpFIBTransaction;
    tmpQry: TpFIBQuery;
    ds_price: TDataSource;
    mds_price: TMemTableEh;
    actList: TActionList;
    actPriceAdd: TAction;
    actPriceDel: TAction;
    mds_labor: TMemTableEh;
    mds_src: TMemTableEh;
    Panel1: TPanel;
    cbbPrice: TComboBox;
    btnPriceAdd: TButton;
    btnPriceDel: TButton;
    Panel2: TPanel;
    DBGridEh1: TDBGridEh;
    Panel3: TPanel;
    vst: TVirtualStringTree;
    btnItemAdd: TButton;
    btnItemEdt: TButton;
    btnItemDel: TButton;
    ActNodeAdd: TAction;
    ActNodeEdt: TAction;
    ActNodeDel: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbbPriceChange(Sender: TObject);
    procedure vstGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
    procedure vstFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vstGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: string);
    procedure actPriceAddExecute(Sender: TObject);
    procedure vstNewText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; NewText: string);
    procedure vstEditing(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
    procedure vstKeyPress(Sender: TObject; var Key: Char);
    procedure ActNodeAddExecute(Sender: TObject);
    procedure ActNodeEdtExecute(Sender: TObject);
    procedure ActNodeDelExecute(Sender: TObject);
    procedure vstDragOver(Sender: TBaseVirtualTree; Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint;
      Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
    procedure vstDragDrop(Sender: TBaseVirtualTree; Source: TObject; DataObject: IDataObject; Formats: TFormatArray;
      Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
    procedure vstAddToSelection(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vstNodeClick(Sender: TBaseVirtualTree; const HitInfo: THitInfo);
    procedure vstStartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure vstDragAllowed(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
  private
    FClinicID: Integer;
    FPeolpeID: Integer;
    FDoctorID: Integer;
    FPriceName: string;
    FFilterStr: string;
    procedure FillCbbPrice(Sender: TObject);
  public
    property ClinicID: Integer read FClinicID;
    property PeolpeID: Integer read FPeolpeID;
    property DoctorID: Integer read FDoctorID;
    property PriceName: string read FPriceName write FPriceName;
    property FilterStr: string read FFilterStr;
//    procedure SetExpFN(Sender: TObject);
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

procedure TForm1.ActNodeAddExecute(Sender: TObject);
begin
//
end;

procedure TForm1.ActNodeDelExecute(Sender: TObject);
begin
//
end;

procedure TForm1.ActNodeEdtExecute(Sender: TObject);
begin
//
end;

procedure TForm1.actPriceAddExecute(Sender: TObject);
var
  Node, ChdNode: PVirtualNode;
  Data: PMyRec;
begin
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

        if Assigned(Data) then
        begin
          Data^.PriceID:= mds_price.FieldByName('BASEPRICE_ID').AsInteger;
          Data^.LaborissueID:= mds_price.FieldByName('LABORISSUE_ID').AsInteger;
          Data^.IsModified:= True;
          Data^.PriceName:= mds_price.FieldByName('LABORISSUE_NAME').AsString;
          Data^.PriceCost:= 0;

          while not mds_price.Eof do
          begin
            ChdNode:= vst.AddChild(Node);
            Data:= vst.GetNodeData(ChdNode);

            if Assigned(Data) then
              Data^.PriceID:= mds_price.FieldByName('BASEPRICE_ID').AsInteger;
              Data^.LaborissueID:= mds_price.FieldByName('LABORISSUE_ID').AsInteger;
              Data^.IsModified:= True;
              Data^.PriceName:= mds_price.FieldByName('BASEPRICE_PROC_NAME').AsString;
              Data^.PriceCost:= mds_price.FieldByName('COST_PROC_PRICE').AsCurrency;

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
      actPriceAddExecute(Sender);
      vst.FullExpand(nil);
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
  NodeLvl: Integer;
begin
//  vst.TreeOptions.SelectionOptions:= vst.TreeOptions.SelectionOptions + [toMultiSelect];
//
//  if (Sender.SelectedCount >= 1) then
//  begin
//    NodeLvl:= Sender.GetNodeLevel(Node);
//    case NodeLvl of
//      0: vst.TreeOptions.SelectionOptions:= vst.TreeOptions.SelectionOptions - [toMultiSelect];
//      1: vst.TreeOptions.SelectionOptions:= vst.TreeOptions.SelectionOptions + [toMultiSelect];
//    end;
//
//    Sender.Selected[Node]:= True;
//  end;
end;

procedure TForm1.vstDragAllowed(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  var Allowed: Boolean);
begin
//  Allowed:= True;
end;

procedure TForm1.vstDragDrop(Sender: TBaseVirtualTree; Source: TObject; DataObject: IDataObject; Formats: TFormatArray;
  Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
var
//  Nodes: TNodeArray;
//  IsAllow: Boolean;
//  i: Integer;
  NodeLvl: Integer;

//  pSource,
  pTarget: PVirtualNode;
  attMode: TVTNodeAttachMode;
  Data: PMyRec;
  Nodes: TNodeArray;
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
  pTarget := Sender.DropTargetNode;
  Nodes:= TVirtualStringTree(Source).GetSortedSelection(True);


  case Mode of
    dmNowhere: attMode := amNoWhere;
    dmAbove:
      begin
        Data:=Sender.GetNodeData(pTarget);
        Self.Caption:= Self.Caption + ' | ' + Data^.PriceName + ' | index = ' + IntToStr(pTarget^.Index);
        NodeLvl:= Sender.GetNodeLevel(pTarget);

        case NodeLvl of
          0: attMode := amAddChildFirst;
          1: attMode := amInsertBefore;
        end;
      end;
    dmOnNode: //attMode// := amInsertAfter;
      begin
        Data:=Sender.GetNodeData(pTarget);
        Self.Caption:= Self.Caption + ' | ' + Data^.PriceName + ' | index = ' + IntToStr(pTarget^.Index);
        NodeLvl:= Sender.GetNodeLevel(pTarget);

        case NodeLvl of
          0: attMode := amAddChildFirst;
          1: attMode := amInsertAfter;
        end;
      end;
     dmBelow:
     begin
        Data:=Sender.GetNodeData(pTarget);
        Self.Caption:= Self.Caption + ' | ' + Data^.PriceName + ' | index = ' + IntToStr(pTarget^.Index);
        NodeLvl:= Sender.GetNodeLevel(pTarget);

        case NodeLvl of
          0: attMode := amAddChildFirst;
          1: attMode := amInsertAfter;
        end;
     end;
  end;

  for i := 0 to Pred(System.Length(Nodes)) do
    Sender.MoveTo(Nodes[i], pTarget, attMode, False);
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
//  case mode of
//    dmNowhere: self.Caption:= 'Nowhere';
//    dmAbove: self.Caption:= 'Above';
//    dmOnNode: self.Caption:= 'OnNode';
//    dmBelow: self.Caption:= 'Below';
//  end;

  if (Sender <> Source) then Exit;
  tgtNode:= Sender.DropTargetNode;//node we are above or around
  drgNode:= TBaseVirtualTree(Source).GetFirstSelected;//first dragged node

  if (Assigned(tgtNode) and Assigned(drgNode))then
  begin
//    Data:= Sender.GetNodeData(tgtNode);
//    Self.Caption:= Self.Caption + ' | ' + Data^.PriceName;
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
  //запрещаем редактировать "стоимость" разделов прайса

  Allowed:= False;
  NodeLvl:= Sender.GetNodeLevel(Node);
  Data:= Sender.GetNodeData(Node);

  if not Assigned(Data) then Exit;
  Allowed:= not ((Column = 1) and (NodeLvl = 0));
end;

procedure TForm1.vstFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Data: PMyRec;
begin
  Data:= Sender.GetNodeData(Node);

  if Assigned(Data) then Finalize(Data^);
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
        1: CellText:= Format('%2.2f %s',[Data^.PriceCost, fs.CurrencyString]);
      end;
  end;
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
  if (Trim(NewText) = '') then Exit;

  Data:= Sender.GetNodeData(Node);
  NodeLvl:= Sender.GetNodeLevel(Node);
  fs:= TFormatSettings.Create;

  case NodeLvl of
    0:
      case Column of
        0: Data^.PriceName:= NewText;
//        1: Exit;
      end;
    1:
      case Column of
        0: Data^.PriceName:= NewText;
        1:
          begin
            NewText:= StringReplace(NewText,'.',',',[rfReplaceAll, rfIgnoreCase]);
            Data^.PriceCost:= StrToCurr(NewText, fs);
          end;
      end;
  end;
end;

procedure TForm1.vstNodeClick(Sender: TBaseVirtualTree; const HitInfo: THitInfo);
begin
//
end;

procedure TForm1.vstStartDrag(Sender: TObject; var DragObject: TDragObject);
var
  Node: PVirtualNode;
  NodeLvl: Integer;
  Nodes: TNodeArray;
  i: Integer;
begin
//  if (vst.SelectedCount = 0) then Exit;
//  Nodes:= vst.GetSortedSelection(True);
//
//  for i := 0 to Pred(System.Length(Nodes)) do
//  begin
//    if (Nodes[i].Parent = nil) then Exit;
//  end;
end;

//procedure TForm1.SetExpFN(Sender: TObject);
//begin
//  if not TObject(Sender).InheritsFrom(TfrxBaseDialogExportFilter) then Exit;
//
//  if mds_info.Active then
//    if not mds_info.IsEmpty then
//      TfrxBaseDialogExportFilter(Sender).FileName:=
//                repPath + mds_info.FieldByName('EXPORT_FN').AsString;
//end;

end.
