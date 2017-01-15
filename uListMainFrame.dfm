object ListMainFrame: TListMainFrame
  Left = 0
  Top = 0
  Width = 562
  Height = 375
  TabOrder = 0
  object ListView1: TListView
    Left = 185
    Top = 0
    Width = 377
    Height = 375
    Align = alClient
    Columns = <
      item
        AutoSize = True
        Caption = 'Name'
      end
      item
        Caption = 'Year'
      end>
    TabOrder = 0
    ViewStyle = vsReport
    ExplicitLeft = -36
    ExplicitTop = -41
    ExplicitWidth = 598
    ExplicitHeight = 416
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 185
    Height = 375
    Align = alLeft
    Caption = 'Panel1'
    TabOrder = 1
    ExplicitLeft = 192
    ExplicitTop = 168
    ExplicitHeight = 41
  end
end
