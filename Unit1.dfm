object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 469
  ClientWidth = 1008
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object pnlTblPrice: TPanel
    Left = 0
    Top = 0
    Width = 353
    Height = 469
    Align = alLeft
    Caption = 'pnlTblPrice'
    TabOrder = 0
    ExplicitHeight = 468
    DesignSize = (
      353
      469)
    object DBGridEh1: TDBGridEh
      Left = 9
      Top = 48
      Width = 337
      Height = 412
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = ds_price
      DynProps = <>
      TabOrder = 0
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
    object pnlPrices: TPanel
      Left = 1
      Top = 1
      Width = 351
      Height = 41
      Align = alTop
      Caption = 'pnlPrices'
      TabOrder = 1
      DesignSize = (
        351
        41)
      object cbbPrice: TComboBox
        Left = 8
        Top = 8
        Width = 279
        Height = 23
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        Text = 'cbbPrice'
        OnChange = cbbPriceChange
      end
      object btnPriceAdd: TButton
        Left = 293
        Top = 8
        Width = 23
        Height = 23
        Action = actPriceFill
        Anchors = [akTop, akRight]
        TabOrder = 1
      end
      object btnPriceDel: TButton
        Left = 322
        Top = 8
        Width = 23
        Height = 23
        Action = actPriceDel
        Anchors = [akTop, akRight]
        TabOrder = 2
      end
    end
  end
  object Panel3: TPanel
    Left = 353
    Top = 0
    Width = 655
    Height = 469
    Align = alClient
    Caption = 'Panel3'
    TabOrder = 1
    ExplicitWidth = 651
    ExplicitHeight = 468
    object pnlEdtNodeData: TPanel
      Left = 1
      Top = 1
      Width = 653
      Height = 41
      Align = alTop
      Caption = 'pnlEdtNodeData'
      TabOrder = 0
      ExplicitWidth = 649
      object pnlItemEdt: TPanel
        Left = 480
        Top = 1
        Width = 172
        Height = 39
        Align = alRight
        Caption = 'pnlItemEdt'
        TabOrder = 0
        ExplicitLeft = 476
        DesignSize = (
          172
          39)
        object Button2: TButton
          Left = 8
          Top = 7
          Width = 75
          Height = 25
          Action = ActNodeDataSave
          Anchors = [akTop, akRight]
          TabOrder = 0
        end
        object Button3: TButton
          Left = 89
          Top = 7
          Width = 75
          Height = 25
          Action = ActNodeDataCancel
          Anchors = [akTop, akRight]
          TabOrder = 1
        end
      end
      object pnlEdtCost: TPanel
        Left = 328
        Top = 1
        Width = 152
        Height = 39
        Align = alRight
        Caption = 'pnlEdtCost'
        TabOrder = 1
        ExplicitLeft = 324
        DesignSize = (
          152
          39)
        object edtPriceCost: TEdit
          Left = 3
          Top = 7
          Width = 121
          Height = 23
          Anchors = [akTop, akRight]
          TabOrder = 0
          Text = '0'
          OnChange = edtPriceCostChange
          OnKeyPress = edtPriceCostKeyPress
        end
        object udPriceCost: TUpDown
          Left = 124
          Top = 7
          Width = 16
          Height = 23
          Anchors = [akTop, akRight]
          Associate = edtPriceCost
          DoubleBuffered = True
          Max = 100000000
          Increment = 50
          ParentDoubleBuffered = False
          TabOrder = 1
          Thousands = False
        end
      end
      object pnlPriceNameEdt: TPanel
        Left = 1
        Top = 1
        Width = 327
        Height = 39
        Align = alClient
        Caption = 'pnlPriceNameEdt'
        TabOrder = 2
        ExplicitWidth = 323
        DesignSize = (
          327
          39)
        object edtPriceName: TEdit
          Left = 7
          Top = 8
          Width = 314
          Height = 23
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          Text = 'edtPriceName'
          ExplicitWidth = 310
        end
      end
    end
    object pnlTreeView: TPanel
      Left = 1
      Top = 42
      Width = 653
      Height = 426
      Align = alClient
      Caption = 'pnlTreeView'
      TabOrder = 1
      ExplicitWidth = 649
      ExplicitHeight = 425
      DesignSize = (
        653
        426)
      object vst: TVirtualStringTree
        Left = 5
        Top = 6
        Width = 559
        Height = 413
        Anchors = [akLeft, akTop, akRight, akBottom]
        DragMode = dmAutomatic
        DragOperations = [doCopy, doMove, doLink]
        Header.AutoSizeIndex = 0
        Header.Height = 20
        Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoShowHint, hoShowImages, hoShowSortGlyphs, hoVisible, hoAutoSpring, hoFullRepaintOnResize]
        HintMode = hmTooltip
        ParentShowHint = False
        PopupMenu = ppmVST
        ShowHint = True
        TabOrder = 0
        TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSort, toAutoTristateTracking, toAutoChangeScale]
        TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toInitOnSave, toWheelPanning]
        TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect, toLevelSelectConstraint, toMultiSelect, toSiblingSelectConstraint, toAlwaysSelectNode]
        OnAddToSelection = vstAddToSelection
        OnCollapsed = vstCollapsed
        OnDragOver = vstDragOver
        OnDragDrop = vstDragDrop
        OnEditing = vstEditing
        OnExpanded = vstExpanded
        OnFreeNode = vstFreeNode
        OnGetText = vstGetText
        OnPaintText = vstPaintText
        OnGetNodeDataSize = vstGetNodeDataSize
        OnInitNode = vstInitNode
        OnKeyPress = vstKeyPress
        OnNewText = vstNewText
        OnNodeClick = vstNodeClick
        OnRemoveFromSelection = vstRemoveFromSelection
        Touch.InteractiveGestures = [igPan, igPressAndTap]
        Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
        Columns = <
          item
            Position = 0
            Text = #1053#1072#1079#1074#1072#1085#1080#1077
            Width = 455
          end
          item
            Position = 1
            Text = #1057#1090#1086#1080#1084#1086#1089#1090#1100
            Width = 100
          end>
      end
      object btnRootAdd: TButton
        Left = 570
        Top = 6
        Width = 75
        Height = 25
        Action = ActRootAdd
        Anchors = [akTop, akRight]
        TabOrder = 1
        ExplicitLeft = 566
      end
      object btnChildAdd: TButton
        Left = 570
        Top = 37
        Width = 75
        Height = 25
        Action = ActChildAdd
        Anchors = [akTop, akRight]
        TabOrder = 2
        ExplicitLeft = 566
      end
      object btnNodeEdt: TButton
        Left = 570
        Top = 68
        Width = 75
        Height = 25
        Action = ActNodeEdt
        Anchors = [akTop, akRight]
        TabOrder = 3
        ExplicitLeft = 566
      end
      object btnNodeDel: TButton
        Left = 570
        Top = 99
        Width = 75
        Height = 25
        Action = ActNodeDel
        Anchors = [akTop, akRight]
        TabOrder = 4
        ExplicitLeft = 566
      end
      object btnNodeRestore: TButton
        Left = 570
        Top = 130
        Width = 75
        Height = 25
        Action = ActNodeRestore
        Anchors = [akTop, akRight]
        TabOrder = 5
        ExplicitLeft = 566
      end
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
    object actPriceFill: TAction
      Category = 'price'
      Caption = '+'
      OnExecute = actPriceFillExecute
    end
    object actPriceDel: TAction
      Category = 'price'
      Caption = '-'
    end
    object ActRootAdd: TAction
      Category = 'Node'
      Caption = 'Add Root'
      OnExecute = ActRootAddExecute
    end
    object ActChildAdd: TAction
      Category = 'Node'
      Caption = 'Add Child'
      OnExecute = ActChildAddExecute
    end
    object ActNodeEdt: TAction
      Category = 'Node'
      Caption = 'Node Edit'
      OnExecute = ActNodeEdtExecute
    end
    object ActNodeDel: TAction
      Category = 'Node'
      Caption = 'Node Del'
      OnExecute = ActNodeDelExecute
    end
    object ActNodeDataSave: TAction
      Category = 'Node'
      Caption = 'Save'
      OnExecute = ActNodeDataSaveExecute
    end
    object ActNodeDataCancel: TAction
      Category = 'Node'
      Caption = 'Cancel'
      OnExecute = ActNodeDataCancelExecute
    end
    object ActChkStatusBtn: TAction
      Category = 'price'
      Caption = 'ActChkStatusBtn'
      OnExecute = ActChkStatusBtnExecute
      OnUpdate = ActChkStatusBtnUpdate
    end
    object actEdtNodeDataOn: TAction
      Category = 'price'
      Caption = 'actEdtNodeDataOn'
      OnExecute = actEdtNodeDataOnExecute
    end
    object actEdtNodeDataOff: TAction
      Category = 'price'
      Caption = 'actEdtNodeDataOff'
      OnExecute = actEdtNodeDataOffExecute
    end
    object ActNodeRestore: TAction
      Category = 'Node'
      Caption = 'Node Restore'
      OnExecute = ActNodeRestoreExecute
    end
    object actAllExpand: TAction
      Category = 'ppmVST'
      Caption = 'Expand all nodes'
      OnExecute = actAllExpandExecute
    end
    object actAllCollaps: TAction
      Category = 'ppmVST'
      Caption = 'Collaps all nodes'
      OnExecute = actAllCollapsExecute
    end
    object actNodeCollaps: TAction
      Category = 'ppmVST'
      Caption = 'Collaps root node'
      OnExecute = actNodeCollapsExecute
    end
    object actNodeExpand: TAction
      Category = 'ppmVST'
      Caption = 'Expand root node'
      OnExecute = actNodeExpandExecute
    end
    object ActChkStatusMnuVST: TAction
      Category = 'ppmVST'
      Caption = 'ActChkStatusMnuVST'
      OnExecute = ActChkStatusMnuVSTExecute
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
  object ppmVST: TPopupMenu
    Left = 738
    Top = 162
    object Expandallnodes1: TMenuItem
      Action = actAllExpand
    end
    object Collapsallnodes1: TMenuItem
      Action = actAllCollaps
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Expandrootnode1: TMenuItem
      Action = actNodeExpand
    end
    object Collapsrootnode1: TMenuItem
      Action = actNodeCollaps
    end
  end
end
