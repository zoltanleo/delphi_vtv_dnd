object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 468
  ClientWidth = 1065
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1065
    Height = 41
    Align = alTop
    Caption = 'Panel1'
    TabOrder = 0
    ExplicitWidth = 1061
    DesignSize = (
      1065
      41)
    object cbbPrice: TComboBox
      Left = 8
      Top = 8
      Width = 302
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Text = 'cbbPrice'
      OnChange = cbbPriceChange
      ExplicitWidth = 298
    end
    object btnPriceAdd: TButton
      Left = 320
      Top = 8
      Width = 23
      Height = 23
      Action = actPriceAdd
      TabOrder = 1
    end
    object btnPriceDel: TButton
      Left = 349
      Top = 8
      Width = 23
      Height = 23
      Action = actPriceDel
      TabOrder = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 320
    Height = 427
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    ExplicitWidth = 316
    ExplicitHeight = 426
    DesignSize = (
      320
      427)
    object DBGridEh1: TDBGridEh
      Left = 8
      Top = 4
      Width = 312
      Height = 416
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = ds_price
      DynProps = <>
      TabOrder = 0
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
  end
  object Panel3: TPanel
    Left = 320
    Top = 41
    Width = 745
    Height = 427
    Align = alRight
    Caption = 'Panel3'
    TabOrder = 2
    ExplicitLeft = 316
    ExplicitHeight = 426
    DesignSize = (
      745
      427)
    object vst: TVirtualStringTree
      Left = 8
      Top = 6
      Width = 649
      Height = 414
      Anchors = [akLeft, akTop, akRight, akBottom]
      DragMode = dmAutomatic
      DragOperations = [doCopy, doMove, doLink]
      Header.AutoSizeIndex = 0
      Header.Height = 20
      Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoShowHint, hoShowImages, hoShowSortGlyphs, hoVisible, hoFullRepaintOnResize]
      HintMode = hmTooltip
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSort, toAutoTristateTracking, toAutoChangeScale]
      TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toEditable, toFullRepaintOnResize, toInitOnSave, toWheelPanning, toEditOnClick]
      TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect, toLevelSelectConstraint, toMultiSelect, toSiblingSelectConstraint, toAlwaysSelectNode]
      OnAddToSelection = vstAddToSelection
      OnDragAllowed = vstDragAllowed
      OnDragOver = vstDragOver
      OnDragDrop = vstDragDrop
      OnEditing = vstEditing
      OnFreeNode = vstFreeNode
      OnGetText = vstGetText
      OnGetNodeDataSize = vstGetNodeDataSize
      OnKeyPress = vstKeyPress
      OnNewText = vstNewText
      OnNodeClick = vstNodeClick
      OnStartDrag = vstStartDrag
      Touch.InteractiveGestures = [igPan, igPressAndTap]
      Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
      Columns = <
        item
          Position = 0
          Text = #1053#1072#1079#1074#1072#1085#1080#1077
          Width = 545
        end
        item
          Position = 1
          Text = #1057#1090#1086#1080#1084#1086#1089#1090#1100
          Width = 100
        end>
    end
    object btnItemAdd: TButton
      Left = 663
      Top = 6
      Width = 75
      Height = 25
      Action = ActNodeAdd
      Anchors = [akTop, akRight]
      TabOrder = 1
    end
    object btnItemEdt: TButton
      Left = 663
      Top = 37
      Width = 75
      Height = 25
      Action = ActNodeEdt
      Anchors = [akTop, akRight]
      TabOrder = 2
    end
    object btnItemDel: TButton
      Left = 663
      Top = 68
      Width = 75
      Height = 25
      Action = ActNodeDel
      Anchors = [akTop, akRight]
      TabOrder = 3
    end
  end
  object tmpDB: TpFIBDatabase
    SQLDialect = 1
    Timeout = 0
    WaitForRestoreConnect = 0
    Left = 56
    Top = 184
  end
  object tmpTrans: TpFIBTransaction
    DefaultDatabase = tmpDB
    TRParams.Strings = (
      'read'
      'nowait'
      'rec_version'
      'read_committed')
    TPBMode = tpbDefault
    Left = 56
    Top = 240
  end
  object tmpQry: TpFIBQuery
    Transaction = tmpTrans
    Database = tmpDB
    Left = 56
    Top = 304
  end
  object ds_price: TDataSource
    AutoEdit = False
    DataSet = mds_price
    Left = 48
    Top = 80
  end
  object mds_price: TMemTableEh
    Params = <>
    Left = 56
    Top = 368
  end
  object actList: TActionList
    Left = 184
    Top = 80
    object actPriceAdd: TAction
      Category = 'price'
      Caption = '+'
      OnExecute = actPriceAddExecute
    end
    object actPriceDel: TAction
      Category = 'price'
      Caption = '-'
    end
    object ActNodeAdd: TAction
      Category = 'Node'
      Caption = 'ActNodeAdd'
      OnExecute = ActNodeAddExecute
    end
    object ActNodeEdt: TAction
      Category = 'Node'
      Caption = 'ActNodeEdt'
      OnExecute = ActNodeEdtExecute
    end
    object ActNodeDel: TAction
      Category = 'Node'
      Caption = 'ActNodeDel'
      OnExecute = ActNodeDelExecute
    end
  end
  object mds_labor: TMemTableEh
    Params = <>
    Left = 144
    Top = 368
  end
  object mds_src: TMemTableEh
    Params = <>
    Left = 176
    Top = 192
  end
end
