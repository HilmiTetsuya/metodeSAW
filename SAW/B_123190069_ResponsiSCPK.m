function varargout = B_123190069_ResponsiSCPK(varargin)
%B_123190069_RESPONSISCPK MATLAB code file for B_123190069_ResponsiSCPK.fig
%      B_123190069_RESPONSISCPK, by itself, creates a new B_123190069_RESPONSISCPK or raises the existing
%      singleton*.
%
%      H = B_123190069_RESPONSISCPK returns the handle to a new B_123190069_RESPONSISCPK or the handle to
%      the existing singleton*.
%
%      B_123190069_RESPONSISCPK('Property','Value',...) creates a new B_123190069_RESPONSISCPK using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to B_123190069_ResponsiSCPK_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      B_123190069_RESPONSISCPK('CALLBACK') and B_123190069_RESPONSISCPK('CALLBACK',hObject,...) call the
%      local function named CALLBACK in B_123190069_RESPONSISCPK.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help B_123190069_ResponsiSCPK

% Last Modified by GUIDE v2.5 26-Jun-2021 05:25:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @B_123190069_ResponsiSCPK_OpeningFcn, ...
                   'gui_OutputFcn',  @B_123190069_ResponsiSCPK_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
   gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before B_123190069_ResponsiSCPK is made visible.
function B_123190069_ResponsiSCPK_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for B_123190069_ResponsiSCPK
handles.output = hObject;
opts = detectImportOptions('DATA RUMAH.xlsx');
opts.SelectedVariableNames = [1,3,4,5,6,7,8];

data = readmatrix('DATA RUMAH.xlsx',opts);
set(handles.uitable6,'Data',data); 
%untuk membaca file data rumah.xlsx dan menampilkanya pada tabel uitable6

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes B_123190069_ResponsiSCPK wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = B_123190069_ResponsiSCPK_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when entered data in editable cell(s) in uitable6.
function uitable6_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable6 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
opts = detectImportOptions('DATA RUMAH.xlsx'); %mendeteksi file DATA RUMAH.xlsx
opts.SelectedVariableNames = [3,4,5,6,7,8]; %mengambil kolom 3 sampai 8

data = readmatrix('DATA RUMAH.xlsx',opts); %menempatkan data dari excel ke var data

%nilai atribut, dimana 0= atribut biaya &1= atribut keuntungan
k=[0,1,1,1,1,1];
w=[0.30, 0.20, 0.23, 0.10, 0.07, 0.10];% bobot untuk masing-masing kriteria

%tahapan 1. normalisasi matriks
%matriks m x n dengan ukuran sebanyak variabel data (input)
[m,n]=size (data); 
R=zeros (m,n); %membuat matriks R, yang merupakan matriks kosong

for j=1:n
    if k(j)==1 %statement untuk kriteria dengan atribut keuntungan
        R(:,j)=data(:,j)./max(data(:,j));
    else
        R(:,j)=min(data(:,j))./data(:,j); %statement untuk kriteria biaya
    end
end

%tahapan kedua, proses penjumlahan dan perkalian dengan bobot sesuai
%kriteria
for i=1:m
    V(i)= sum(w.*R(i,:));
end
%proses perangkingan untuk mengurutkan
nilai = sort(V,'descend');

%memilih hanya 20 nilai terbaik (20 rumah terbaik)
for i=1:20
hasil(i) = nilai(i);
end

opts2 = detectImportOptions('DATA RUMAH.xlsx'); %mendeteksi file DATA RUMAH.xlsx
opts2.SelectedVariableNames = [2]; %memilih hanya kolom Nama Rumah

nama = readmatrix('DATA RUMAH.xlsx',opts2); %mengambil nama rumah dari file dan menyimpan di var nama

%perulangan untuk mencari nama rumah dari 20 nilai terbaik tadi
for i=1:20
 for j=1:m
   if(hasil(i) == V(j))
    rekomendasi(i) = nama(j);
    break
   end
 end
end
%melakukan transpose pada rekomendasi agar tampilan menjadi per baris
rekomendasi = rekomendasi';

set(handles.uitable7,'Data',rekomendasi);

% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
