object frmItem: TfrmItem
  Left = 0
  Top = 0
  Caption = 'frmItem'
  ClientHeight = 425
  ClientWidth = 444
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnPaint = FormPaint
  TextHeight = 15
  object pnlTree: TPanel
    Left = 0
    Top = 0
    Width = 444
    Height = 386
    Align = alClient
    Caption = 'pnlTree'
    TabOrder = 0
    DesignSize = (
      444
      386)
    object PriceTree: TVirtualStringTree
      Left = 8
      Top = 8
      Width = 429
      Height = 372
      Anchors = [akLeft, akTop, akRight, akBottom]
      Header.AutoSizeIndex = 0
      Header.MainColumn = -1
      TabOrder = 0
      OnDblClick = PriceTreeDblClick
      OnFreeNode = PriceTreeFreeNode
      OnGetText = PriceTreeGetText
      OnGetNodeDataSize = PriceTreeGetNodeDataSize
      Touch.InteractiveGestures = [igPan, igPressAndTap]
      Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
      Columns = <>
    end
  end
  object pnlBtns: TPanel
    Left = 0
    Top = 386
    Width = 444
    Height = 39
    Align = alBottom
    Caption = 'pnlBtns'
    TabOrder = 1
    DesignSize = (
      444
      39)
    object lblEmptyWarninig: TLabel
      Left = 64
      Top = 16
      Width = 95
      Height = 15
      Caption = 'lblEmptyWarninig'
    end
    object btnSave: TButton
      Left = 281
      Top = 7
      Width = 75
      Height = 25
      Action = actChoice
      Anchors = [akRight, akBottom]
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 362
      Top = 7
      Width = 75
      Height = 25
      Action = actCancel
      Anchors = [akRight, akBottom]
      TabOrder = 1
    end
  end
  object mds_items: TMemTableEh
    Params = <>
    Left = 64
    Top = 152
  end
  object mds_issue: TMemTableEh
    Params = <>
    Left = 168
    Top = 152
  end
  object actList: TActionList
    Left = 160
    Top = 48
    object actChoice: TAction
      Caption = 'actChoice'
      OnExecute = actChoiceExecute
    end
    object actCancel: TAction
      Caption = 'actCancel'
      OnExecute = actCancelExecute
    end
  end
end
