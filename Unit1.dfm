object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 471
  ClientWidth = 873
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
  object pnlTbl: TPanel
    Left = 0
    Top = 0
    Width = 201
    Height = 471
    Align = alLeft
    Caption = 'pnlTbl'
    TabOrder = 0
    ExplicitHeight = 470
    DesignSize = (
      201
      471)
    object DBGridEh1: TDBGridEh
      Left = 9
      Top = 48
      Width = 185
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
      Width = 199
      Height = 41
      Align = alTop
      Caption = 'pnlPrices'
      TabOrder = 1
      DesignSize = (
        199
        41)
      object cbbPrice: TComboBox
        Left = 8
        Top = 8
        Width = 98
        Height = 23
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        Text = 'cbbPrice'
        OnChange = cbbPriceChange
      end
      object btnPriceAdd: TButton
        Left = 112
        Top = 8
        Width = 23
        Height = 23
        Action = actPriceAdd
        Anchors = [akTop, akRight]
        TabOrder = 1
      end
      object btnPriceDel: TButton
        Left = 170
        Top = 8
        Width = 23
        Height = 23
        Action = actPriceDel
        Anchors = [akTop, akRight]
        TabOrder = 2
      end
      object Button1: TButton
        Left = 141
        Top = 8
        Width = 23
        Height = 23
        Action = actPriceEdt
        Anchors = [akTop, akRight]
        TabOrder = 3
      end
    end
  end
  object pnlTree: TPanel
    Left = 201
    Top = 0
    Width = 672
    Height = 471
    Align = alClient
    Caption = 'pnlTree'
    TabOrder = 1
    ExplicitWidth = 668
    ExplicitHeight = 470
    object pnlEdtNodeData: TPanel
      Left = 1
      Top = 1
      Width = 670
      Height = 56
      Align = alTop
      Caption = 'pnlEdtNodeData'
      TabOrder = 0
      ExplicitWidth = 666
      object pnlItemEdt: TPanel
        Left = 497
        Top = 1
        Width = 172
        Height = 54
        Align = alRight
        Caption = 'pnlItemEdt'
        TabOrder = 0
        ExplicitLeft = 493
        DesignSize = (
          172
          54)
        object Button2: TButton
          Left = 8
          Top = 22
          Width = 75
          Height = 25
          Action = ActNodeDataSave
          Anchors = [akTop, akRight]
          TabOrder = 0
        end
        object Button3: TButton
          Left = 89
          Top = 22
          Width = 75
          Height = 25
          Action = ActNodeDataCancel
          Anchors = [akTop, akRight]
          TabOrder = 1
        end
      end
      object pnlEdtCost: TPanel
        Left = 311
        Top = 1
        Width = 153
        Height = 54
        Align = alRight
        Caption = 'pnlEdtCost'
        TabOrder = 1
        ExplicitLeft = 307
        DesignSize = (
          153
          54)
        object Label3: TLabel
          Left = 9
          Top = 2
          Width = 60
          Height = 15
          Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100
        end
        object edtPriceCost: TEdit
          Left = 6
          Top = 23
          Width = 121
          Height = 23
          Anchors = [akTop, akRight]
          TabOrder = 0
          Text = '0'
          OnChange = edtPriceCostChange
          OnKeyPress = edtPriceCostKeyPress
        end
        object udPriceCost: TUpDown
          Left = 127
          Top = 23
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
        Width = 228
        Height = 54
        Align = alClient
        Caption = 'pnlPriceNameEdt'
        TabOrder = 2
        ExplicitWidth = 224
        DesignSize = (
          228
          54)
        object Label1: TLabel
          Left = 3
          Top = 2
          Width = 52
          Height = 15
          ParentCustomHint = False
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        end
        object edtPriceName: TEdit
          Left = 7
          Top = 23
          Width = 215
          Height = 23
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          Text = 'edtPriceName'
          ExplicitWidth = 211
        end
      end
      object pnlEdtCodeLiter: TPanel
        Left = 229
        Top = 1
        Width = 82
        Height = 54
        Align = alRight
        Caption = 'pnlEdtCodeLiter'
        TabOrder = 3
        ExplicitLeft = 225
        object Label2: TLabel
          Left = 6
          Top = 2
          Width = 64
          Height = 15
          Caption = #1050#1086#1076' '#1083#1080#1090#1077#1088#1099
        end
        object edtCodeLiter: TEdit
          Left = 7
          Top = 23
          Width = 59
          Height = 23
          TabOrder = 0
          Text = 'edtCodeLiter'
          OnKeyPress = edtCodeLiterKeyPress
        end
      end
      object pnlItemSelect: TPanel
        Left = 464
        Top = 1
        Width = 33
        Height = 54
        Align = alRight
        Caption = 'pnlItemSelect'
        ShowCaption = False
        TabOrder = 4
        ExplicitLeft = 460
        DesignSize = (
          33
          54)
        object btnItemSelect: TButton
          Left = 4
          Top = 23
          Width = 23
          Height = 23
          Action = ActItemSelect
          Anchors = [akTop, akRight]
          TabOrder = 0
        end
      end
    end
    object pnlTreeView: TPanel
      Left = 1
      Top = 147
      Width = 670
      Height = 323
      Align = alClient
      Caption = 'pnlTreeView'
      TabOrder = 1
      ExplicitWidth = 666
      ExplicitHeight = 322
      DesignSize = (
        670
        323)
      object vst: TVirtualStringTree
        Left = 5
        Top = 6
        Width = 576
        Height = 310
        Anchors = [akLeft, akTop, akRight, akBottom]
        DragMode = dmAutomatic
        DragOperations = [doCopy, doMove, doLink]
        Header.AutoSizeIndex = 0
        HintMode = hmTooltip
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Touch.InteractiveGestures = [igPan, igPressAndTap]
        Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
        Columns = <
          item
            Position = 0
            Style = vsOwnerDraw
            Text = #1053#1072#1079#1074#1072#1085#1080#1077
            Width = 295
          end
          item
            Position = 1
            Style = vsOwnerDraw
            Text = #1057#1090#1086#1080#1084#1086#1089#1090#1100
            Width = 100
          end>
      end
      object btnRootAdd: TButton
        Left = 587
        Top = 6
        Width = 75
        Height = 25
        Action = ActRootAdd
        Anchors = [akTop, akRight]
        TabOrder = 1
        ExplicitLeft = 583
      end
      object btnChildAdd: TButton
        Left = 587
        Top = 37
        Width = 75
        Height = 25
        Action = ActChildAdd
        Anchors = [akTop, akRight]
        TabOrder = 2
        ExplicitLeft = 583
      end
      object btnNodeEdt: TButton
        Left = 587
        Top = 68
        Width = 75
        Height = 25
        Action = ActNodeEdt
        Anchors = [akTop, akRight]
        TabOrder = 3
        ExplicitLeft = 583
      end
      object btnNodeDel: TButton
        Left = 587
        Top = 99
        Width = 75
        Height = 25
        Action = ActNodeDel
        Anchors = [akTop, akRight]
        TabOrder = 4
        ExplicitLeft = 583
      end
      object btnNodeRestore: TButton
        Left = 587
        Top = 130
        Width = 75
        Height = 25
        Action = ActNodeRestore
        Anchors = [akTop, akRight]
        TabOrder = 5
        ExplicitLeft = 583
      end
      object btnPriceSave: TButton
        Left = 587
        Top = 260
        Width = 75
        Height = 25
        Action = actPriceSave
        Anchors = [akRight, akBottom]
        TabOrder = 6
        ExplicitLeft = 583
        ExplicitTop = 259
      end
      object btnPriceCancel: TButton
        Left = 587
        Top = 291
        Width = 75
        Height = 25
        Action = actPriceCancel
        Anchors = [akRight, akBottom]
        TabOrder = 7
        ExplicitLeft = 583
        ExplicitTop = 290
      end
    end
    object pnlTreeSettings: TPanel
      Left = 1
      Top = 57
      Width = 670
      Height = 55
      Align = alTop
      Caption = 'pnlTreeSettings'
      TabOrder = 2
      ExplicitWidth = 666
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
      object chbHideDelNode: TCheckBox
        Left = 280
        Top = 5
        Width = 193
        Height = 17
        Caption = 'Hide deleted node'
        TabOrder = 2
        OnClick = chbHideDelNodeClick
      end
    end
    object pnlSetPriceName: TPanel
      Left = 1
      Top = 112
      Width = 670
      Height = 35
      Align = alTop
      Caption = 'pnlSetPriceName'
      TabOrder = 3
      ExplicitWidth = 666
      DesignSize = (
        670
        35)
      object edtSetPriceName: TEdit
        Left = 5
        Top = 6
        Width = 657
        Height = 23
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        Text = 'edtSetPriceName'
        ExplicitWidth = 653
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
      'write'
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
    DataSet = mds_common
    Left = 48
    Top = 80
  end
  object mds_common: TMemTableEh
    Params = <>
    Left = 56
    Top = 368
  end
  object actList: TActionList
    Left = 136
    Top = 88
    object actPriceFill: TAction
      Category = 'price'
      Caption = 'actPriceFill'
      OnExecute = actPriceFillExecute
    end
    object actPriceDel: TAction
      Category = 'price'
      Caption = '-'
      OnExecute = actPriceDelExecute
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
    object actPriceEdt: TAction
      Category = 'price'
      Caption = '...'
      OnExecute = actPriceEdtExecute
    end
    object actPriceAdd: TAction
      Category = 'price'
      Caption = '+'
      OnExecute = actPriceAddExecute
    end
    object actTreeShowOn: TAction
      Category = 'price'
      Caption = 'actTreeShowOn'
      OnExecute = actTreeShowOnExecute
    end
    object actTreeShowOff: TAction
      Category = 'price'
      Caption = 'actTreeShowOff'
      OnExecute = actTreeShowOffExecute
    end
    object actPriceSave: TAction
      Category = 'price'
      Caption = 'Price Save'
      OnExecute = actPriceSaveExecute
    end
    object actPriceCancel: TAction
      Category = 'price'
      Caption = 'Price Cancel'
      OnExecute = actPriceCancelExecute
    end
    object ActItemSelect: TAction
      Category = 'Node'
      Caption = '...'
      OnExecute = ActItemSelectExecute
    end
  end
  object mds_laborissue: TMemTableEh
    Params = <>
    Left = 360
    Top = 360
  end
  object mds_src: TMemTableEh
    Params = <>
    Left = 136
    Top = 176
  end
  object ppmVST: TPopupMenu
    Left = 226
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
  object mds_baseprice: TMemTableEh
    Params = <>
    Left = 360
    Top = 296
  end
  object mds_price: TMemTableEh
    Params = <>
    Left = 360
    Top = 232
  end
  object qryLaborissue: TpFIBQuery
    Transaction = tmpTrans
    Database = tmpDB
    Left = 498
    Top = 363
  end
  object qryBaseprice: TpFIBQuery
    Transaction = tmpTrans
    Database = tmpDB
    Left = 498
    Top = 299
  end
end
