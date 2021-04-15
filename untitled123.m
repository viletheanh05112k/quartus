function varargout = untitled123(varargin)
% UNTITLED123 MATLAB code for untitled123.fig
%      UNTITLED123, by itself, creates a new UNTITLED123 or raises the existing
%      singleton*.
%
%      H = UNTITLED123 returns the handle to a new UNTITLED123 or the handle to
%      the existing singleton*.
%
%      UNTITLED123('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED123.M with the given input arguments.
%
%      UNTITLED123('Property','Value',...) creates a new UNTITLED123 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled123_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled123_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled123

% Last Modified by GUIDE v2.5 08-Apr-2021 13:28:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled123_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled123_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
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

% --- Executes just before untitled123 is made visible.
function untitled123_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled123 (see VARARGIN)

% Choose default command line output for untitled123
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled123 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = untitled123_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im2

[path, user_cancel] = imgetfile();
if user_cancel
    msgbox(sprintf('Invalid Selection') ,'Error','Warn');
    return
end
im = imread(path);
im = im2double(im);
im2 = im;
axes(handles.axes1);
imshow(im)
title('Input')

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im

axes(handles.axes2)
bw = im2bw(im, 0.7);
label = bwlabel(bw);

stats = regionprops(label, 'Solidity', 'Area');
denisty = [stats.Solidity];
area = [stats.Area];

high_dense_area = denisty > 0.5;
max_area = max(area(high_dense_area));
tumor_label = find(area == max_area);
tumor = ismember(label, tumor_label);

se = strel('square',5);
tumor = imdilate(tumor,se);

B = bwboundaries(tumor,'noholes');

imshow(im)
hold on

for i = 1:length(B)
    plot(B{i}(:,2), B{i}(:,1), 'y','linewidth',1.75)
end
title('Otput')
hold off

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im

axes(handles.axes3)
bw = im2bw(im, 0.7);
label = bwlabel(bw);

stats = regionprops(label, 'Solidity', 'Area');
denisty = [stats.Solidity];
area = [stats.Area];

high_dense_area = denisty > 0.5;
max_area = max(area(high_dense_area));
tumor_label = find(area == max_area);
tumor = ismember(label, tumor_label);

se = strel('square',5);
tumor = imdilate(tumor,se);


B = bwboundaries(tumor,'noholes');

imshow(tumor)
hold on

for i = 1:length(B)
    plot(B{i}(:,2), B{i}(:,1), 'y','linewidth',1.75)
end
title('Otput')
hold off


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
  