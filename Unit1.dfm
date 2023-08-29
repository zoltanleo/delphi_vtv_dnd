object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 471
  ClientWidth = 848
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
    Height = 471
    Align = alLeft
    Caption = 'pnlTblPrice'
    TabOrder = 0
    ExplicitHeight = 470
    DesignSize = (
      353
      471)
    object DBGridEh1: TDBGridEh
      Left = 9
      Top = 48
      Width = 337
      Height = 414
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
    Width = 495
    Height = 471
    Align = alClient
    Caption = 'Panel3'
    TabOrder = 1
    ExplicitWidth = 491
    ExplicitHeight = 470
    object pnlEdtNodeData: TPanel
      Left = 1
      Top = 1
      Width = 493
      Height = 41
      Align = alTop
      Caption = 'pnlEdtNodeData'
      TabOrder = 0
      ExplicitWidth = 489
      object pnlItemEdt: TPanel
        Left = 320
        Top = 1
        Width = 172
        Height = 39
        Align = alRight
        Caption = 'pnlItemEdt'
        TabOrder = 0
        ExplicitLeft = 316
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
        Left = 168
        Top = 1
        Width = 152
        Height = 39
        Align = alRight
        Caption = 'pnlEdtCost'
        TabOrder = 1
        ExplicitLeft = 164
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
        Width = 167
        Height = 39
        Align = alClient
        Caption = 'pnlPriceNameEdt'
        TabOrder = 2
        ExplicitWidth = 163
        DesignSize = (
          167
          39)
        object edtPriceName: TEdit
          Left = 7
          Top = 8
          Width = 154
          Height = 23
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          Text = 'edtPriceName'
          ExplicitWidth = 150
        end
      end
    end
    object pnlTreeView: TPanel
      Left = 1
      Top = 97
      Width = 493
      Height = 373
      Align = alClient
      Caption = 'pnlTreeView'
      TabOrder = 1
      ExplicitTop = 104
      ExplicitWidth = 489
      ExplicitHeight = 365
      DesignSize = (
        493
        373)
      object vst: TVirtualStringTree
        Left = 5
        Top = 6
        Width = 399
        Height = 360
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
        OnRemoveFromSelection = vstRemoveFromSelection
        Touch.InteractiveGestures = [igPan, igPressAndTap]
        Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
        ExplicitHeight = 415
        Columns = <
          item
            Position = 0
            Text = #1053#1072#1079#1074#1072#1085#1080#1077
            Width = 295
          end
          item
            Position = 1
            Text = #1057#1090#1086#1080#1084#1086#1089#1090#1100
            Width = 100
          end>
      end
      object btnRootAdd: TButton
        Left = 410
        Top = 6
        Width = 75
        Height = 25
        Action = ActRootAdd
        Anchors = [akTop, akRight]
        TabOrder = 1
        ExplicitLeft = 406
      end
      object btnChildAdd: TButton
        Left = 410
        Top = 37
        Width = 75
        Height = 25
        Action = ActChildAdd
        Anchors = [akTop, akRight]
        TabOrder = 2
        ExplicitLeft = 406
      end
      object btnNodeEdt: TButton
        Left = 410
        Top = 68
        Width = 75
        Height = 25
        Action = ActNodeEdt
        Anchors = [akTop, akRight]
        TabOrder = 3
        ExplicitLeft = 406
      end
      object btnNodeDel: TButton
        Left = 410
        Top = 99
        Width = 75
        Height = 25
        Action = ActNodeDel
        Anchors = [akTop, akRight]
        TabOrder = 4
        ExplicitLeft = 406
      end
      object btnNodeRestore: TButton
        Left = 410
        Top = 130
        Width = 75
        Height = 25
        Action = ActNodeRestore
        Anchors = [akTop, akRight]
        TabOrder = 5
        ExplicitLeft = 406
      end
    end
    object Panel1: TPanel
      Left = 1
      Top = 42
      Width = 493
      Height = 55
      Align = alTop
      Caption = 'Panel1'
      TabOrder = 2
      object chbSetZeroCost: TCheckBox
        Left = 5
        Top = 6
        Width = 140
        Height = 17
        Caption = 'Set cost as zero'
        TabOrder = 0
        OnClick = chbSetZeroCostClick
      end
      object chbShowUpdatedPrice: TCheckBox
        Left = 5
        Top = 29
        Width = 164
        Height = 17
        Caption = 'Highlight updated prices'
        TabOrder = 1
        OnClick = chbShowUpdatedPriceClick
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
    object N2: TMenuItem
      Caption = '-'
    end
    object AddRoot1: TMenuItem
      Action = ActRootAdd
    end
    object AddChild1: TMenuItem
      Action = ActChildAdd
    end
    object NodeEdit1: TMenuItem
      Action = ActNodeEdt
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object NodeDel1: TMenuItem
      Action = ActNodeDel
    end
    object NodeRestore1: TMenuItem
      Action = ActNodeRestore
    end
  end
end
