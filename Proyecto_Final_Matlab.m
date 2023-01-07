function varargout = Proyecto_Final_Matlab(varargin)
% PROYECTO_FINAL_MATLAB M-file for Proyecto_Final_Matlab.fig
%      PROYECTO_FINAL_MATLAB, by itself, creates a new PROYECTO_FINAL_MATLAB or raises the existing
%      singleton*.
%
%      H = PROYECTO_FINAL_MATLAB returns the handle to a new PROYECTO_FINAL_MATLAB or the handle to
%      the existing singleton*.
%
%      PROYECTO_FINAL_MATLAB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROYECTO_FINAL_MATLAB.M with the given input arguments.
%
%      PROYECTO_FINAL_MATLAB('Property','Value',...) creates a new PROYECTO_FINAL_MATLAB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Proyecto_Final_Matlab_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Proyecto_Final_Matlab_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Proyecto_Final_Matlab

% Last Modified by GUIDE v2.5 01-Dec-2010 23:01:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Proyecto_Final_Matlab_OpeningFcn, ...
                   'gui_OutputFcn',  @Proyecto_Final_Matlab_OutputFcn, ...
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


% --- Executes just before Proyecto_Final_Matlab is made visible.
function Proyecto_Final_Matlab_OpeningFcn(hObject, eventdata, handles, varargin)
 axis([0 1 0 120])
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Proyecto_Final_Matlab (see VARARGIN)

% Choose default command line output for Proyecto_Final_Matlab
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Proyecto_Final_Matlab wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Proyecto_Final_Matlab_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
msgbox('Adquicision de Datos MATLAB ... Juan David Cerquera 2007270391','Acerca de');
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
ans=questdlg('�Desea salir del programa?','SALIR','Si','No','No');
if strcmp(ans,'No')
return;
end
clear;
clc;
close all
%close(gcbf)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in grilla.
function grilla_Callback(hObject, eventdata, handles)
a=get(handles.grilla,'value');
if(a==1)
    grid on
else
    grid off
end
    
% hObject    handle to grilla (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of grilla


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
tao=str2num(get(handles.adqui,'string'));
PS=serial('COM5');
set(PS,'Baudrate',9600); % se configura la velocidad a 9600 Baudios
set(PS,'StopBits',1); % se configura bit de parada a uno
set(PS,'DataBits',8); % se configura que el dato es de 8 bits, debe estar entre 5 y 8
set(PS,'Parity','none'); % se configura sin paridad
set(PS,'Terminator','CR/LF');% �c� caracter con que finaliza el env�o 
set(PS,'OutputBufferSize',1); % �n� es el n�mero de bytes a enviar
set(PS,'InputBufferSize' ,1); % �n� es el n�mero de bytes a recibir
set(PS,'Timeout',5); % 5 segundos de tiempo de espera

t=[];
K1=[];
K=[];
i=0;

while i<=tao   
    t=[t i];  
    set(handles.edit2,'string',i);
    fopen(PS);
    fwrite(PS,1,'uint8');
    pause(0.01)
    K1=[fread(PS,1,'uint8')];
    K1=[fread(PS,1,'uint8')];
    fclose(PS);
    K1=K1/255*100;
    K=[K K1];
    if i==tao
        fopen(PS);
        fwrite(PS,0,'uint8');  
        fclose(PS);
    end
%Gr�fica
    plot(t,K,'g')
%Margen
    if i==0
        axis([0 i+1 0 120])
    else
        axis([0 i 0 120])
    end     
%grilla
    a=get(handles.grilla,'value');
    if(a==1)
        grid on
    else
        grid off
    end
    pause(0.01)
    i=i+1;
end
delete(PS);
clear PS;
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function adqui_Callback(hObject, eventdata, handles)
% hObject    handle to adqui (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of adqui as text
%        str2double(get(hObject,'String')) returns contents of adqui as a double


% --- Executes during object creation, after setting all properties.
function adqui_CreateFcn(hObject, eventdata, handles)
% hObject    handle to adqui (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
a=[];
set(handles.adqui,'string',a);
set(handles.edit2,'string',a);
a=[0];
plot(a,a)
axis([0 1 0 120])
%grilla
    a=get(handles.grilla,'value');
    if(a==1)
        grid on
    else
        grid off
    end
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


