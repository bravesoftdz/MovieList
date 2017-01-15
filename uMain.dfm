object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 643
  ClientWidth = 1034
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 120
  TextHeight = 17
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1034
    Height = 624
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'TabSheet1'
      object Button1: TButton
        Left = 21
        Top = 21
        Width = 98
        Height = 33
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'Button1'
        TabOrder = 0
        OnClick = Button1Click
      end
      object ToolBar2: TToolBar
        Left = 0
        Top = 0
        Width = 1026
        Height = 29
        ButtonHeight = 25
        ButtonWidth = 83
        Caption = 'ToolBar2'
        ShowCaptions = True
        TabOrder = 1
        object ToolButton3: TToolButton
          Left = 0
          Top = 0
          Caption = 'LoadAll'
          ImageIndex = 0
          OnClick = ToolButton3Click
        end
        object ToolButton4: TToolButton
          Left = 83
          Top = 0
          Caption = 'ToolButton4'
          ImageIndex = 1
          OnClick = ToolButton4Click
        end
      end
      object ListView1: TListView
        Left = 242
        Top = 29
        Width = 784
        Height = 563
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alClient
        Columns = <
          item
            AutoSize = True
            Caption = 'Name'
          end
          item
            Caption = 'Year'
            Width = 65
          end>
        TabOrder = 2
        ViewStyle = vsReport
      end
      object Panel1: TPanel
        Left = 0
        Top = 29
        Width = 242
        Height = 563
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alLeft
        Caption = 'Panel1'
        TabOrder = 3
        object rgMediaType: TRadioGroup
          Left = 1
          Top = 1
          Width = 240
          Height = 138
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Align = alTop
          Caption = 'rgMediaType'
          TabOrder = 0
        end
      end
    end
    object TabSheet2: TTabSheet
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'TabSheet2'
      ImageIndex = 1
      object Memo1: TMemo
        Left = 0
        Top = 29
        Width = 1026
        Height = 563
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alClient
        Lines.Strings = (
          'Memo1')
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object ToolBar1: TToolBar
        Left = 0
        Top = 0
        Width = 1026
        Height = 29
        ButtonHeight = 25
        ButtonWidth = 111
        Caption = 'ToolBar1'
        ShowCaptions = True
        TabOrder = 1
        object ToolButton1: TToolButton
          Left = 0
          Top = 0
          Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074' '#1041#1044
          ImageIndex = 0
          OnClick = ToolButton1Click
        end
        object ToolButton2: TToolButton
          Left = 111
          Top = 0
          Caption = 'ToolButton2'
          ImageIndex = 1
          OnClick = ToolButton2Click
        end
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 624
    Width = 1034
    Height = 19
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Panels = <
      item
        Width = 150
      end>
  end
  object SQLConnection1: TSQLConnection
    ConnectionName = 'SQLITECONNECTION'
    DriverName = 'Sqlite'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Sqlite'
      'Database=db.sqlite')
    Left = 40
    Top = 104
  end
  object SQLQuery1: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLConnection1
    Left = 144
    Top = 216
  end
end
