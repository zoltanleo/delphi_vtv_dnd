object frmItem: TfrmItem
  Left = 0
  Top = 0
  Caption = 'frmItem'
  ClientHeight = 426
  ClientWidth = 448
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
    Width = 448
    Height = 387
    Align = alClient
    Caption = 'pnlTree'
    TabOrder = 0
    ExplicitWidth = 444
    ExplicitHeight = 386
    DesignSize = (
      448
      387)
    object PriceTree: TVirtualStringTree
      Left = 8
      Top = 8
      Width = 433
      Height = 373
      Anchors = [akLeft, akTop, akRight, akBottom]
      Header.AutoSizeIndex = 0
      Header.MainColumn = -1
      TabOrder = 0
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
    Top = 387
    Width = 448
    Height = 39
    Align = alBottom
    Caption = 'pnlBtns'
    TabOrder = 1
    ExplicitTop = 386
    ExplicitWidth = 444
    DesignSize = (
      448
      39)
    object lblEmptyWarninig: TLabel
      Left = 64
      Top = 16
      Width = 95
      Height = 15
      Caption = 'lblEmptyWarninig'
    end
    object btnSave: TButton
      Left = 285
      Top = 7
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'btnSave'
      TabOrder = 0
      OnClick = btnSaveClick
      ExplicitLeft = 281
    end
    object btnCancel: TButton
      Left = 366
      Top = 7
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'btnCancel'
      TabOrder = 1
      OnClick = btnCancelClick
      ExplicitLeft = 362
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
end
