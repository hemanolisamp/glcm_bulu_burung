function varargout = GLCM(varargin)
% GLCM MATLAB code for GLCM.fig
%      GLCM, by itself, creates a new GLCM or raises the existing
%      singleton*.
%
%      H = GLCM returns the handle to a new GLCM or the handle to
%      the existing singleton*.
%
%      GLCM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GLCM.M with the given input arguments.
%
%      GLCM('Property','Value',...) creates a new GLCM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GLCM_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GLCM_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GLCM

% Last Modified by GUIDE v2.5 20-May-2019 10:35:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GLCM_OpeningFcn, ...
                   'gui_OutputFcn',  @GLCM_OutputFcn, ...
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


% --- Executes just before GLCM is made visible.
function GLCM_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GLCM (see VARARGIN)

% Choose default command line output for GLCM
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GLCM wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GLCM_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
open = guidata(gcbo);
[filename,direktory] = uigetfile({'*.jpg;*.bmp;*.tif;*.png'},'openimage');
I = imread (filename);
set(open.figure1,'CurrentAxes',open.axes1);
set(imagesc(I)); 
set(open.axes1,'Userdata',I);
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
open=guidata(gcbo);
y = get(open.axes1,'Userdata');
I = rgb2gray(y);
set(open.figure1,'CurrentAxes',open.axes2);
set(imagesc(I));colormap('gray');
set(open.axes2,'Userdata',I);
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
open=guidata(gcbo);
y = get(open.axes1,'Userdata');
I = rgb2gray(y);
pixel_dist = 1;
GLCM = graycomatrix(I,'Offset',[0 pixel_dist; -pixel_dist pixel_dist; -pixel_dist 0; -pixel_dist -pixel_dist]);
stats = graycoprops(GLCM,{'contrast','correlation','energy','homogeneity'});
Contrast = stats.Contrast;
Correlation = stats.Correlation;
Energy = stats.Energy;
Homogeneity = stats.Homogeneity;

data = get(handles.uitable1,'Data');
data{1,1} = num2str(Contrast(1));
data{1,2} = num2str(Contrast(2));
data{1,3} = num2str(Contrast(3));
data{1,4} = num2str(Contrast(4));
data{1,5} = num2str(mean(Contrast));
 
data{2,1} = num2str(Correlation(1));
data{2,2} = num2str(Correlation(2));
data{2,3} = num2str(Correlation(3));
data{2,4} = num2str(Correlation(4));
data{2,5} = num2str(mean(Correlation));
 
data{3,1} = num2str(Energy(1));
data{3,2} = num2str(Energy(2));
data{3,3} = num2str(Energy(3));
data{3,4} = num2str(Energy(4));
data{3,5} = num2str(mean(Energy));
 
data{4,1} = num2str(Homogeneity(1));
data{4,2} = num2str(Homogeneity(2));
data{4,3} = num2str(Homogeneity(3));
data{4,4} = num2str(Homogeneity(4));
data{4,5} = num2str(mean(Homogeneity));
 
set(handles.uitable1,'Data',data,'ForegroundColor',[0 0 0])

Contrast = mean(stats.Contrast);
set(handles.text3,'String',num2str(Contrast));

if(mean(stats.Contrast) >= 0.63000)&&(mean(stats.Contrast) <= 0.9000)
    set(handles.text3,'String','HALUS');
else(mean(stats.Contrast) <= 1.2000)&&(mean(stats.Contrast) >= 4.5771)
    set(handles.text3,'String','KASAR');
end
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
