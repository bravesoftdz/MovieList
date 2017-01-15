unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DbxSqlite, Data.DB, Data.SqlExpr,
  Vcl.StdCtrls, Data.DBXCommon, Vcl.ComCtrls,
  Vcl.ToolWin, System.RegularExpressions,
  System.Generics.Collections, Data.FMTBcd,
  System.StrUtils, uFilmInfo, Vcl.ButtonGroup, Vcl.CheckLst, Vcl.ExtCtrls,
  uListMainFrame;

type

  TMediaSheet = class(TObject)
    TabSheet: TTabSheet;
    Frame: TListMainFrame;
    constructor Create(PageControl: TPageControl; Caption: string); overload;

  end;

  TMediaSheetList = TObjectList<TMediaSheet>;

  TFilmInfo = class(TObject)
    ID: Integer;
    FilmName: string;
    FilmEngName: string;
    FilmYear: Integer;
    // Node: ;
    // constructor Create(ATree: TBaseVirtualTree; AParent: PVirtualNode); override;
    // destructor Destroy; override;
  end;

  TFilmList = TObjectList<TFilmInfo>;

  TMainForm = class(TForm)
    SQLConnection1: TSQLConnection;
    Button1: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    StatusBar1: TStatusBar;
    TabSheet2: TTabSheet;
    Memo1: TMemo;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolBar2: TToolBar;
    ToolButton3: TToolButton;
    SQLQuery1: TSQLQuery;
    ToolButton4: TToolButton;
    ListView1: TListView;
    Panel1: TPanel;
    rgMediaType: TRadioGroup;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
  private
    { Private declarations }
    FilmList: TFilmList;

    Pages: TMediaSheetList;

    procedure LoadFromDB();
    procedure LoadMediaTypes();
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure PopulateTable(Connection: TSQLConnection);
var
  Query: String;
  iCounterPerSec: TLargeInteger;
  T1, T2: TLargeInteger;
  i: Integer;
  Transaction: TDBXSqliteTransaction;
begin
  Query := 'CREATE TABLE ExampleTable(id INT, name VARCHAR2(50))';
  try
    Connection.Execute(Query, nil);

    QueryPerformanceFrequency(iCounterPerSec);
    QueryPerformanceCounter(T1);

    Transaction := Connection.BeginTransaction as TDBXSqliteTransaction;

    for i := 0 to 100 do
    begin
      Query := Format('INSERT INTO ExampleTable VALUES(%d,"test")', [i]);
      Connection.Execute(Query, nil);
    end;

    Connection.CommitFreeAndNil(TDBXTransaction(Transaction));
    QueryPerformanceCounter(T2);
    ShowMessage(FormatFloat('0.0000', (T2 - T1) / iCounterPerSec) + ' сек.');

  except
    on E: Exception do
      ShowMessage('Exception raised with message: ' + E.Message);
  end;
end;

procedure AddItemAName(Connection: TSQLConnection; inFilmName, inLink: string;
  inYear: Integer);
var
  Query: String;
  Transaction: TDBXSqliteTransaction;

  iName, iLink, iYear: string;
begin
  if (Length(inFilmName) > 0) then
  begin
    iName := '"' + inFilmName + '"';
    if Length(inLink) > 0 then
      iLink := '"' + inLink + '"'
    else
      iLink := 'NULL';
    if inYear > 1900 then
      iYear := IntToStr(inYear)
    else
      iYear := 'NULL';

    Transaction := Connection.BeginTransaction as TDBXSqliteTransaction;
    Query := Format
      ('INSERT INTO fFilms (FilmName, KinopoiskLink, Year) VALUES (%s, %s, %s)',
      [iName, iLink, iYear]);
    Connection.Execute(Query, nil);
    Connection.CommitFreeAndNil(TDBXTransaction(Transaction));
  end;
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  SQLConnection1.Connected := True;

  if SQLConnection1.Connected then
    Button1.Caption := 'Connected'
  else
    Button1.Caption := 'Not connected';
  PopulateTable(SQLConnection1);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin


  if not SQLConnection1.Connected then
    SQLConnection1.Connected := True;

  StatusBar1.Panels[0].Width := Self.ClientWidth;
  StatusBar1.Panels[0].Text := SQLConnection1.params.Values['Database'];

  { Заставляем работать вторичные ключи }
  SQLConnection1.ExecuteDirect('PRAGMA foreign_keys=ON');

  FilmList := TFilmList.Create();
  Pages := TMediaSheetList.Create();
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  // if Assigned(FilmList) then
  // FreeAndNil(FilmList);
end;

procedure TMainForm.LoadFromDB;
var
  sQuery: String;
  Transaction: TDBXSqliteTransaction;
  Index: Integer;
  item: TListItem;
begin
  sQuery := ('select * from fFilms');

  // SQLQuery1 := TSQLQuery.Create(nil);
  // SQLQuery1.SQLConnection := SQLConnection1;

  SQLQuery1.Close;
  // SQLQuery1.Edit;
  // SQLQuery1.ClearFields;
  SQLQuery1.SQL.Clear;
  SQLQuery1.SQL.Add(sQuery);

  SQLQuery1.Open;
  // SQLQuery1.Last;
  // SQLQuery1.First;
  while not SQLQuery1.Eof do
  begin
    Index := FilmList.Add(TFilmInfo.Create);
    FilmList[index].ID := SQLQuery1.FieldByName('ID').AsInteger;
    FilmList[index].FilmName := SQLQuery1.FieldByName('FilmName').AsString;
    FilmList[index].FilmYear := StrToIntDef(SQLQuery1.FieldByName('Year')
      .AsString, 0);
    // FilmList[index].FilmName :=  Results.FieldByName('FilmName').Value;

    // ListView1.AddItem(FilmList[Index].FilmName, FilmList[Index]);

    item := ListView1.Items.Add;
    item.Data := FilmList[Index];
    item.Caption := FilmList[Index].FilmName;

    item.SubItems.Add(IfThen(FilmList[Index].FilmYear > 0,
      IntToStr(FilmList[Index].FilmYear)));

    SQLQuery1.Next;
  end;

end;

procedure TMainForm.LoadMediaTypes;
var
  sQuery: String;
  Transaction: TDBXSqliteTransaction;
  Index: Integer;
  item: TListItem;
begin
  sQuery := ('select * from fTags where Tag_type = 1');
  SQLQuery1.Close;
  SQLQuery1.SQL.Clear;
  SQLQuery1.SQL.Add(sQuery);
  SQLQuery1.Open;
  while not SQLQuery1.Eof do
  begin
    rgMediaType.Items.Add(SQLQuery1.FieldByName('Title').AsString);

    Pages.Add(TMediaSheet.Create(PageControl1, SQLQuery1.FieldByName('Title')
      .AsString));


    // Index := FilmList.Add(TFilmInfo.Create);
    // FilmList[index].ID := SQLQuery1.FieldByName('ID').AsInteger;
    // FilmList[index].FilmName := SQLQuery1.FieldByName('Title').AsString;

    // item := ListView1.Items.Add;
    // item.Data := FilmList[Index];
    // item.Caption := FilmList[Index].FilmName;

    // item.SubItems.Add(IfThen(FilmList[Index].FilmYear > 0, IntToStr(FilmList[Index].FilmYear)));

    SQLQuery1.Next;
  end;
end;

procedure TMainForm.ToolButton1Click(Sender: TObject);
var
  aItem: string;
  aYear: Integer;
  aName, aLink: string;
  Math: tmatch;

  Query: String;
  Transaction: TDBXSqliteTransaction;

  iName, iLink, iYear: string;
begin
  Transaction := SQLConnection1.BeginTransaction as TDBXSqliteTransaction;

  aLink := '';
  aYear := 0;
  for aItem in Memo1.Lines do
  begin
    aName := aItem;
    // AddItemAName(SQLConnection1, aName, aLink, aYear);

    if (Length(aName) > 0) then
    begin

      iName := '"' + aName + '"';
      if Length(aLink) > 0 then
        iLink := '"' + aLink + '"'
      else
        iLink := 'NULL';
      if aYear > 1900 then
        iYear := IntToStr(aYear)
      else
        iYear := 'NULL';

      Query := Format
        ('INSERT INTO fFilms (FilmName, KinopoiskLink, Year) VALUES (%s, %s, %s)',
        [iName, iLink, iYear]);
      SQLConnection1.Execute(Query, nil);

    end;
  end;
  SQLConnection1.CommitFreeAndNil(TDBXTransaction(Transaction));

end;

procedure TMainForm.ToolButton2Click(Sender: TObject);
var
  aItem: string;
  aYear: Integer;
  aName, aLink: string;
  Math: tmatch;

  Query: String;
  Transaction: TDBXSqliteTransaction;
  i, code: Integer;
  iName, iLink, iYear: string;
begin
  Transaction := SQLConnection1.BeginTransaction as TDBXSqliteTransaction;

  for i := 117 to 132 do
  begin
    case i of
      87 .. 91:
        code := 6;
      92 .. 98:
        code := 5;
      99 .. 116:
        code := 4;
      117 .. 132:
        code := 3;
      133 .. 153:
        code := 2;
    else
      code := 0;
    end;

    Query := Format
      ('INSERT INTO lTagsToFilms (fkFilms, fkTags) VALUES (%d, %d)', [i, code]);
    SQLConnection1.Execute(Query, nil);

  end;

  SQLConnection1.CommitFreeAndNil(TDBXTransaction(Transaction));
end;

procedure TMainForm.ToolButton3Click(Sender: TObject);
var
  item: TFilmInfo;
begin

  // for Item in FilmList do
  // begin
  // FilmList.Delete(FilmList.IndexOf(Item));
  // end;

  // VirtualStringTree2.FreeOnRelease
  Self.Caption := IntToStr(FilmList.Count);

  LoadMediaTypes;
  LoadFromDB;

end;

procedure TMainForm.ToolButton4Click(Sender: TObject);
var
  item: TFilmInfo;
begin
  Memo1.Clear;
  for item in FilmList do
  begin
    Memo1.Lines.Add(item.FilmName);
  end;
end;

{ TFilmInfo }

// constructor TFilmInfo.Create(ATree: TBaseVirtualTree; AParent: PVirtualNode);
// begin
// inherited Create(ATree, AParent);
// end;

// destructor TFilmInfo.Destroy;
// begin
//
// inherited Destroy;
// end;

{ TMediaSheet }

constructor TMediaSheet.Create(PageControl: TPageControl; Caption: string);
begin
  inherited Create;
  TabSheet := TTabSheet.Create(PageControl);
  TabSheet.Parent := PageControl;
  TabSheet.PageControl := PageControl;
  TabSheet.Caption := Caption;
  TabSheet.Name := Caption;
  TabSheet.Align := alClient;

  Frame := TListMainFrame.Create(TabSheet);
  Frame.Parent := TabSheet;
  Frame.Align := alClient;
end;

end.
