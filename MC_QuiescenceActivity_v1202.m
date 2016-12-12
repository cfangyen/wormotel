function varargout = MC_QuiescenceActivity_v1202(varargin)
% MC_QUIESCENCEACTIVITY_V1202 M-file for MC_QuiescenceActivity_v1202.fig
%      MC_QUIESCENCEACTIVITY_V1202, by itself, creates a new MC_QUIESCENCEACTIVITY_V1202 or raises the existing
%      singleton*.
%
%      H = MC_QUIESCENCEACTIVITY_V1202 returns the handle to a new MC_QUIESCENCEACTIVITY_V1202 or the handle to
%      the existing singleton*.
%
%      MC_QUIESCENCEACTIVITY_V1202('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MC_QUIESCENCEACTIVITY_V1202.M with the given input arguments.
%
%      MC_QUIESCENCEACTIVITY_V1202('Property','Value',...) creates a new MC_QUIESCENCEACTIVITY_V1202 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MC_QuiescenceActivity_v1202_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MC_QuiescenceActivity_v1202_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MC_QuiescenceActivity_v1202

% Last Modified by GUIDE v2.5 17-Jun-2014 08:53:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @MC_QuiescenceActivity_v1202_OpeningFcn, ...
    'gui_OutputFcn',  @MC_QuiescenceActivity_v1202_OutputFcn, ...
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


% --- Executes just before MC_QuiescenceActivity_v1202 is made visible.
function MC_QuiescenceActivity_v1202_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MC_QuiescenceActivity_v1202 (see VARARGIN)
handles.EndMessage = cell(1,4);
handles.EndMessage{1} = 'Click "Load Image" to start.';
handles.EndMessage{2} = 'Click "Load Image" to start.';
handles.EndMessage{3} = 'Click "Load Data" to start.';
handles.EndMessage{4} = 'Click "Load Data" to start.';
axes(handles.axes2);


% Choose default command line output for MC_QuiescenceActivity_v1202
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MC_QuiescenceActivity_v1202 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MC_QuiescenceActivity_v1202_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on key press over figure1 with no controls selected.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if CurrTab(handles) == 1
    PathName = handles.PathName;
    FileType = handles.FileType;
    CurrFrame = str2num(get(handles.edit_CurrFrame, 'String'));
    FilePrefix = get(handles.edit4, 'String');
    val=double(get(gcf,'CurrentCharacter'));
    OldFrame = CurrFrame;

    switch val
        case 28  % left arrow
            CurrFrame=CurrFrame-1;
        case 29  % right arrow
            CurrFrame=CurrFrame+1;
        case 30  % up arrow
            CurrFrame=CurrFrame-10;
        case 31  % down arrow
            CurrFrame=CurrFrame+10;
        case 48  % 0
            CurrFrame=CurrFrame-100;
        case 46  % .
            CurrFrame=CurrFrame+100;
        otherwise
    end

    if CurrFrame < 1
        CurrFrame = 1;
    end
    set(handles.edit_CurrFrame, 'String', num2str(CurrFrame));

    try
        NameImg = [FilePrefix num2str(CurrFrame,'%04d') FileType];
        Img = imread([PathName NameImg]);
        imagesc(Img);
        set(handles.axes1,'XTick',[],'YTick',[])
        set(handles.MainText1,'string',['Displaying ' NameImg '.'])
        drawnow;
    catch
        CurrFrame = OldFrame;
        set(handles.edit_CurrFrame, 'String', num2str(CurrFrame));
        set(handles.MainText1,'string',['File error or out of range: ' NameImg '. Frame may be out of range.'])
    end
end




% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Load Sample Image and Display
[FileName PathName] = uigetfile( ...
    {'*.bmp;*.jpg','Image Files(*.bmp,*.jpg)';'*.bmp','BMP files(*.bmp)';'*.jpg','JPG files(*.jpg)';...
    '*.*','All Files(*.*)'});
ImgEx = imread([PathName FileName]);
[ImgYsize ImgXsize] = size(ImgEx);
handles.image2 = imagesc(ImgEx); colormap gray;hold on;
set(gca,'XTick',[],'YTick',[]);
FileType = FileName(end-3:end);
% Save data
handles.FileName = FileName;
handles.PathName = PathName;
handles.ImgXsize = ImgXsize;
handles.ImgYsize = ImgYsize;
handles.FileType = FileType;
guidata(hObject,handles);
% End Message
set(handles.MainText2,'string','Image loaded successfully.   Click "Select ROI" to continue.')
set(handles.text8,'string','Image Loaded')

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Prompt Number of ROI
Ans = inputdlg({sprintf('Selection Method\n1. Auto Selection (Web Method)\n2. Manual Selection\n3. Load ROI File')},'ROI Selection',1,{'1'});
SelectMethod = str2num(Ans{1});
switch SelectMethod
    case 1
        TextShift = 2;
        %% Prompt for # ROWs and # COLs
        Fields={'Number of Rows','Number of Columns'};
        Ans = inputdlg(Fields,'ROI Auto-Selection',1,{'6','8'});
        NumRow = str2num(Ans{1});
        NumCol = str2num(Ans{2});
        NumROI = NumRow*NumCol;
        set(handles.MainText2,'string','Click at the Center of UPPER-LEFT well.')
        [ULx ULy] = ginput(1);
        set(handles.MainText2,'string','Click at the Center of UPPER-RIGHT Well')
        [URx URy] = ginput(1);
        set(handles.MainText2,'string','Click at the Center of LOWER-LEFT Well')
        [LLx LLy] = ginput(1);
        set(handles.MainText2,'string','Click at the Center of LOWER-RIGHT Well')
        [LRx LRy] = ginput(1);

        ROICenter = zeros(NumROI,2);
        Lx = ULx + (LLx-ULx)/(NumRow-1)*(0:(NumRow-1));
        Ly = ULy + (LLy-ULy)/(NumRow-1)*(0:(NumRow-1));
        Rx = URx + (LRx-URx)/(NumRow-1)*(0:(NumRow-1));
        Ry = URy + (LRy-URy)/(NumRow-1)*(0:(NumRow-1));

        n = 0;
        for r = 1:NumRow
            for c = 1:NumCol
                n = n + 1;
                ROICenter(n,:) = [Lx(r)+(Rx(r)-Lx(r))/(NumCol-1)*(c-1) Ly(r)+(Ry(r)-Ly(r))/(NumCol-1)*(c-1)];
            end
        end

        for n = 1:NumROI
            plot(ROICenter(n,1),ROICenter(n,2),'*r')
        end

        plot(ULx,ULy,'*m')
        plot(URx,URy,'*m')
        plot(LLx,LLy,'*m')
        plot(LRx,LRy,'*m')

        set(handles.MainText2,'string','Click at the UPPER-LEFT corner of a representative well.')
        [ROIx1 ROIy1] = ginput(1);

        set(handles.MainText2,'string','Click at the LOWER-RIGHT of the SAME well.')
        [ROIx2 ROIy2] = ginput(1);

        ROIxsize = round(ROIx2-ROIx1);
        ROIysize = round(ROIy2-ROIy1);
        ROIxdist = ceil(ROIxsize/2);
        ROIydist = floor(ROIysize/2);
        ROI = zeros(NumROI,4);
        ROILine =zeros(1,NumROI);
        ROILabel =zeros(1,NumROI);
        for n = 1:NumROI
            ROI(n,1:4) = [ROICenter(n,1)-ROIxdist ROICenter(n,1)+ROIxdist ...
                ROICenter(n,2)-ROIydist ROICenter(n,2)+ROIydist];
            ROILine(n) = plot([ROI(n,1) ROI(n,2) ROI(n,2) ROI(n,1) ROI(n,1)], ...
                [ROI(n,3) ROI(n,3) ROI(n,4) ROI(n,4) ROI(n,3)],'Color','blue','LineWidth',1);
            ROILabel(n) = text(ROI(n,1)+10,ROI(n,3)+20,num2str(n),'Color','white','FontSize',10);
        end

    case 2
        Ans = inputdlg({'Enter number of ROI'},'Manual Selection',1,{''});
        NumROI = str2num(Ans{1});
        ROI = zeros(NumROI,4);
        ROILine =zeros(1,NumROI);
        ROILabel =zeros(1,NumROI);
        for n = 1:NumROI
            set(handles.MainText2,'string',sprintf(['Select ROI#' ...
                num2str(n) ': Click at UPPER-LEFT corner, then at LOWER-RIGHT corner.']))
            [ROI(n,1) ROI(n,3)] = ginput(1);
            p(1) = plot([ROI(n,1) ROI(n,1)], [1 handles.ImgYsize], '-r');
            p(2) = plot([1 handles.ImgXsize], [ROI(n,3) ROI(n,3)], '-r');
            [ROI(n,2) ROI(n,4)] = ginput(1);
            set(p(:),'Visible','off');
            ROILine(n) = plot([ROI(n,1) ROI(n,2) ROI(n,2) ROI(n,1) ROI(n,1)], ...
                [ROI(n,3) ROI(n,3) ROI(n,4) ROI(n,4) ROI(n,3)]);
            ROILabel(n) = text(ROI(n,1)+10,ROI(n,3)+20,num2str(n),'Color','white','FontSize',10);
        end
        ROIxsize=0;
        ROIysize=0;
        ROICenter=0;
end

handles = guidata(hObject);
% if min(min(round(ROI))) < 1 | max(max(round(ROI(1:2)))) > ImgXsize | max(max(round(ROI(3:4)))) > ImgYsize
%     set(handles.MainText2,'string','Warning: One or more ROIs exceeds image boundary. Reduce ROI size or re-center edge ROIs to avoid error.')
% else
%     set(handles.MainText2,'string','Use the "Adjust ROI" Panel to adjust ROI size and center.')
% end
set(handles.uipanel7,'visible','on');
set(handles.uipanel3,'visible','off');
set(handles.edit1,'string',num2str(ROIxsize));
set(handles.edit2,'string',num2str(ROIysize));

% Adjust new lines
handles = guidata(hObject);
handles.ROI = ROI;
handles.NumROI = NumROI;
handles.ROICenter = ROICenter;
handles.SelectedROI = [];
handles.ROILine = ROILine;
handles.ROILabel = ROILabel;
guidata(hObject,handles);

% set(handles.image2,'ButtonDownFcn',@MC_QuiescenceActivity_v1202('Image2_ButtonDownFcn',hObject,handles))



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
happy=0;

while happy==0
    % Prompt User for Parameters
    fields={'Start Frame','End Frame','Time/Frame(sec)',sprintf('Image File Prefix\nNote: All image files must be named \nin the format PREFIX####.ext'),'BKG Threshold for ActVal Analysis','Spatial Filter Size','Frame Skip',sprintf('Synchronized Analysis?\n0: Off-line 1: Real-time'),sprintf('Autosave per N frames\n 0: Turn off autosave')};
    try
        Ans = inputdlg(fields,'Set Parameters',1,{num2str(handles.NumStart),num2str(handles.NumEnd),num2str(handles.TimepImg),handles.FilePrefix,num2str(handles.NoiseThres),num2str(handles.GaussianStd),num2str(handles.frameSkip),num2str(handles.RealTime),num2str(handles.AutoSaveFrames)});
    catch
        Ans = inputdlg(fields,'Set Parameters',1,{'1','100000','10','Image','0.2','1','10','1','1000'});
    end
    NumStart = str2num(Ans{1});
    NumEnd = str2num(Ans{2});
    TimepImg = str2num(Ans{3});
    FilePrefix = Ans{4};
    NoiseThres = str2num(Ans{5});
    GaussianStd = str2num(Ans{6});
    frameSkip = str2num(Ans{7});
    RealTime = str2num(Ans{8});
    AutoSaveFrames = str2num(Ans{9});

    % Calculate activity in two images to display for user
    x=-5:5;
    y=x;
    [xx yy]=meshgrid(x,y);
    gau=exp(-sqrt(xx.^2+yy.^2)/GaussianStd^2);
    sample1=double(imread([handles.PathName 'Image' num2str(NumStart+1,'%04d') handles.FileType]));
    sample2=double(imread([handles.PathName 'Image' num2str(NumStart,'%04d') handles.FileType]));
    Diff1=abs(sample1-sample2)./(abs(sample1+sample2));
    smoothedDiff1 = conv2(Diff1,gau,'same');
    BinaryDiff1 = smoothedDiff1>NoiseThres;

    %imagesc(Diff1,[0 prctile(max(Diff1),90)])
    imagesc(Diff1,[0 0.7])
    an=inputdlg('Click ok to display thresholded image');
    imagesc(BinaryDiff1)

    myans=inputdlg({'Are you happy with parameters?  Type 1 if yes or 0 to reset: '},'Accept Parameters?',1,{'0'});
    happy=str2num(myans{1});
end

% AutoSave Path
if AutoSaveFrames ~= 0
    [SaveName SavePath] = uiputfile('.mat','AutoSave To');
else
    SaveName = [];
    SavePath = [];
end

% Save Data
handles.NumStart = NumStart;
handles.NumEnd = NumEnd;
handles.TimepImg = TimepImg;
handles.frameSkip = frameSkip;
handles.FilePrefix = FilePrefix;
handles.NoiseThres = NoiseThres;
handles.RealTime = RealTime;
handles.GaussianStd=GaussianStd;
handles.AutoSaveFrames = AutoSaveFrames;
handles.SaveName = SaveName;
handles.SavePath = SavePath;
guidata(hObject,handles);

% End Message
set(handles.MainText2,'string','Parameters set successfully.   Click "Start Analysis" to execute program.')
set(handles.text12,'string',['Start Frame: ' num2str(NumStart)])
set(handles.text13,'string',['End Frame: ' num2str(NumEnd)])
switch RealTime
    case 0
        set(handles.text22,'string',sprintf(['Off-line Analysis']))
    case 1
        set(handles.text22,'string',sprintf(['Real-Time Analysis\n(' num2str(TimepImg) ' sec/frame)']))
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Main Activity Analysis
FilePrefix = handles.FilePrefix;
NoiseThres = handles.NoiseThres;
PathName = handles.PathName;
FileType = handles.FileType;
NumStart = handles.NumStart;
NumEnd = handles.NumEnd;
NumROI = handles.NumROI;
ROI = handles.ROI;
RealTime = handles.RealTime;
TimepImg = handles.TimepImg;
AutoSaveFrames = handles.AutoSaveFrames;
SaveName = handles.SaveName;
SavePath = handles.SavePath;
frameSkip=handles.frameSkip;


ActVal = zeros(NumROI,NumEnd-NumStart+1);
ActValS = zeros(NumROI,NumEnd-NumStart+1);
dayRecorded = zeros(1,NumEnd-NumStart+1);
hourRecorded = zeros(1,NumEnd-NumStart+1);
minuteRecorded = zeros(1,NumEnd-NumStart+1);
secondRecorded = zeros(1,NumEnd-NumStart+1);
Error = 0;
AnalysisTPF = 'N/A';
% Create Gaussian Filter
x=-5:5;
y=x;
[xx yy]=meshgrid(x,y);
gau=exp(-sqrt(xx.^2+yy.^2)/handles.GaussianStd^2);

tic;
NumA = NumStart;
ROI=round(ROI);

while NumA <= NumEnd
    try
        NameA = [FilePrefix num2str(NumA,'%04d') FileType];
        myTime = dir([PathName NameA]);
        dayRecorded(NumA-NumStart+1) = str2num(myTime.date(1:2));
        hourRecorded(NumA-NumStart+1) = str2num(myTime.date(13:14));
        minuteRecorded(NumA-NumStart+1) = str2num(myTime.date(16:17));
        secondRecorded(NumA-NumStart+1) = str2num(myTime.date(19:20));

        if NumA > NumStart
            ImgB = ImgA;
            if mod(NumA-NumStart-frameSkip-1,frameSkip)==0
                ImgC = ImgA;
            end
        end
        ImgA = single(imread([PathName NameA]));

        % Activity Analysis --------------------------------------
        if NumA > NumStart
            ImgDif = abs(double(ImgA-ImgB))./double(ImgA+ImgB);
            for n = 1:NumROI
                ROIDif = ImgDif(ROI(n,3):ROI(n,4),ROI(n,1):ROI(n,2));
                ROIDifT = conv2(ROIDif,gau,'same');
                ROIDifT = ROIDifT>NoiseThres;
                ActVal(n,NumA-NumStart) = sum(sum(ROIDifT));
            end

            if mod(NumA-NumStart-frameSkip,frameSkip)==0
                ImgDifSkip = abs(double(ImgA-ImgC))./double(ImgA+ImgC);
                for n = 1:NumROI
                    ROIDifSkip = ImgDifSkip(ROI(n,3):ROI(n,4),ROI(n,1):ROI(n,2));
                    ROIDifTSkip = conv2(ROIDifSkip,gau,'same');
                    ROIDifTSkip = ROIDifTSkip>NoiseThres;
                    ActValS(n,NumA-NumStart) = sum(sum(ROIDifTSkip));
                end
            end

            set(handles.MainText2,'string',['Analysis in progress: ' num2str(NumA-NumStart) '/' num2str(NumEnd-NumStart+1) '. Images processed at ' AnalysisTPF ' sec/frame.'])
            pause(0.001);
        end
        if mod(NumA,10) == 0
            AnalysisTPF = num2str(toc/10,'%0.3f');
            tic;
        end
        if mod(NumA,handles.AutoSaveFrames) == 0
            save([SavePath SaveName],'FilePrefix','PathName','FileType','NoiseThres', ...
                'NumStart','NumEnd','TimepImg','NumROI','ROI','ActVal','ActValS','frameSkip','dayRecorded','hourRecorded','minuteRecorded','secondRecorded');
        end
        NumA = NumA + 1;
    catch
        switch RealTime
            case 0
                set(handles.MainText2,'string',['File error: ' NameA '. ' ...
                    'Frames processed: ' num2str(NumStart) ' to ' num2str(NumA-1) '. '])
                break
            case 1
                pause(TimepImg);
        end
    end
    if NumA == NumEnd
        set(handles.MainText2,'string','Activity analysis complete.   Click "SAVE" to save results.')
    end
end

% Save Data
handles.ActVal = ActVal;
handles.ActValS = ActValS;
handles.dayRecorded=dayRecorded;
handles.hourRecorded=hourRecorded;
handles.minuteRecorded=minuteRecorded;
handles.secondRecorded=secondRecorded;
guidata(hObject,handles);



% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

FilePrefix = handles.FilePrefix;
PathName = handles.PathName;
FileType = handles.FileType;
NoiseThres = handles.NoiseThres;
NumStart = handles.NumStart;
NumEnd = handles.NumEnd;
TimepImg = handles.TimepImg;
NumROI = handles.NumROI;
ROI = handles.ROI;
ActVal = handles.ActVal;
ActValS = handles.ActValS;
frameSkip = handles.frameSkip;
dayRecorded = handles.dayRecorded;
hourRecorded = handles.hourRecorded;
minuteRecorded = handles.minuteRecorded;
secondRecorded = handles.secondRecorded;

[SaveName SavePath] = uiputfile('.mat','Save Result');
save([SavePath SaveName],'FilePrefix','PathName','FileType','NoiseThres', ...
    'NumStart','NumEnd','TimepImg','NumROI','ROI','ActVal','ActValS','frameSkip','dayRecorded','hourRecorded','minuteRecorded','secondRecorded');


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double

ImgXsize = handles.ImgXsize;
ImgYsize = handles.ImgYsize;
set(handles.MainText2,'string','Adjusting and replotting...')
pause(0.0000001);
ROIxdist = str2num(get(handles.edit1,'string'))/2;
ROIydist = str2num(get(handles.edit2,'string'))/2;
ROICenter = handles.ROICenter;
ROI = zeros(handles.NumROI,4);
for n = 1:handles.NumROI
    ROI(n,1:4) = [ROICenter(n,1)-ROIxdist ROICenter(n,1)+ROIxdist ...
        ROICenter(n,2)-ROIydist ROICenter(n,2)+ROIydist];
end
RePlotROI(handles);
if min(min(round(ROI))) < 1 | max(max(round(ROI(1:2)))) > ImgXsize | max(max(round(ROI(3:4)))) > ImgYsize
    set(handles.MainText2,'string','Warning: One or more ROIs exceeds image boundary. Reduce ROI size or re-center edge ROIs to avoid error.')
else
    set(handles.MainText2,'string','Use the "Adjust ROI" Panel to adjust ROI size and center.')
end
handles.ROI = round(ROI);
guidata(hObject,handles);

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



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


edit1_Callback(hObject, eventdata, handles)

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


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.edit1,'string',num2str(str2num(get(handles.edit1,'string'))+1))
edit1_Callback(hObject, eventdata, handles)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.edit1,'string',num2str(str2num(get(handles.edit1,'string'))-1))
edit1_Callback(hObject, eventdata, handles)

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.edit2,'string',num2str(str2num(get(handles.edit2,'string'))+1))
edit1_Callback(hObject, eventdata, handles)

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.edit2,'string',num2str(str2num(get(handles.edit2,'string'))-1))
edit1_Callback(hObject, eventdata, handles)

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel7,'visible','off');
set(handles.uipanel3,'visible','on');
% End Message
set(handles.MainText2,'string','ROI selection completed.   Click "Set Parameters" to continue.')
set(handles.text10,'string','ROI Selected')
set(handles.text11,'string',['Number of ROI: ' num2str(handles.NumROI)])


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1
set(handles.Panel_Preview,'visible','on')
set(handles.Panel_ActivityAnalysis,'visible','off')
set(handles.Panel_QuiescenceAnalysis,'visible','off')
set(handles.Panel_PlotData,'visible','off')
set(handles.ActivityAnalyze,'visible','off')
set(handles.axes1,'visible','on')
axes(handles.axes1)


% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton2
set(handles.Panel_Preview,'visible','off')
set(handles.Panel_ActivityAnalysis,'visible','on')
set(handles.Panel_QuiescenceAnalysis,'visible','off')
set(handles.Panel_PlotData,'visible','off')
set(handles.ActivityAnalyze,'visible','off')
set(handles.axes1,'visible','on')
axes(handles.axes2)

% --- Executes on button press in togglebutton3.
function togglebutton3_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton3
set(handles.Panel_Preview,'visible','off')
set(handles.Panel_ActivityAnalysis,'visible','off')
set(handles.Panel_QuiescenceAnalysis,'visible','on')
set(handles.Panel_PlotData,'visible','off')
set(handles.ActivityAnalyze,'visible','off')
axes(handles.axes3)
set(handles.axes3,'visible','on')


% --- Executes on button press in togglebutton4.
function togglebutton4_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton4
set(handles.Panel_Preview,'visible','off')
set(handles.Panel_ActivityAnalysis,'visible','off')
set(handles.Panel_QuiescenceAnalysis,'visible','off')
set(handles.ActivityAnalyze,'visible','off')
set(handles.Panel_PlotData,'visible','on')
set(handles.axes1,'visible','off')




% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Load Sample Image and Display
[FileName PathName] = uigetfile( ...
    {'*.bmp;*.jpg','Image Files(*.bmp,*.jpg)';'*.bmp','BMP files(*.bmp)';'*.jpg','JPG files(*.jpg)';...
    '*.*','All Files(*.*)'});
ImgEx = imread([PathName FileName]);
imagesc(ImgEx); colormap gray;
set(gca,'XTick',[],'YTick',[]);
FileType = FileName(end-3:end);

% Save data
handles.FileName = FileName;
handles.PathName = PathName;
handles.FileType = FileType;
guidata(hObject,handles);
% End Message
set(handles.edit_CurrFrame, 'String','1');
set(handles.MainText1,'string','Image loaded successfully.  Use keyboard to browse through images.')

function edit_CurrFrame_Callback(hObject, eventdata, handles)
% hObject    handle to edit_CurrFrame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_CurrFrame as text
%        str2double(get(hObject,'String')) returns contents of edit_CurrFrame as a double


% --- Executes during object creation, after setting all properties.
function edit_CurrFrame_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_CurrFrame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function Panel_Preview_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Panel_Preview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% function MainText(hObject,handles,msg)
% set(handles.MainText2,'string','string',msg);
% handles.EndMessage{CurrTab(handles)} = msg;
% guidata(hObject,handles);

function TabIndex = CurrTab(handles)
ToggleVal = zeros(1,4);
ToggleVal(1) = get(handles.togglebutton1,'Value');
ToggleVal(2) = get(handles.togglebutton2,'Value');
ToggleVal(3) = get(handles.togglebutton3,'Value');
ToggleVal(4) = get(handles.togglebutton4,'Value');
TabIndex = find(ToggleVal);





% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


set(handles.uipanel6,'visible','on');
set(handles.uipanel8,'visible','off');
set(handles.MainText2,'string','Adjust ROI size with the panel at the left.')



% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


set(handles.uipanel6,'visible','off');
set(handles.uipanel8,'visible','on');
set(handles.MainText2,'string','Click on ROIs to select. Use "Move Selection" Panel to shift selected ROIs.');


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%
%
% ???????
% function Image2_ButtonDownFcn(hObject, handles)
% % hObject    handle to axes2 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% disp('111')
% uiresume;
% if get(handles.uipanel8,'visible') == 'on'
%
%     ClickLocPre = get(handles.axes2,'CurrentPoint');
%     ClickLoc = ClickLocPre(1,1:2);
%     ROIClicked = find(ROI(:,1) < ClickLoc(1) & ROI(:,2) > ClickLoc(1) & ROI(:,3) < ClickLoc(2) & ROI(:,4) > ClickLoc(2));
%     handles.ROISelected = [handles.ROISelected ROIClicked];
%     guidata(hObject,handles);
% end
%



function RePlotROI(handles)
ROI = handles.ROI;
for n = 1:handles.NumROI
    set(handles.ROILine(n),'XData',[ROI(n,1) ROI(n,2) ROI(n,2) ROI(n,1) ROI(n,1)],'YData', ...
        [ROI(n,3) ROI(n,3) ROI(n,4) ROI(n,4) ROI(n,3)]);
    set(handles.ROILabel(n),'Position',[ROI(n,1)+10,ROI(n,3)+20,0]);
end
for s = handles.SelectedROI
    set(ROILine(s),'color','red')
end



%
%
% % --- Executes on mouse press over axes background.
% function axes2_ButtonDownFcn(hObject, eventdata, handles)
% % hObject    handle to axes2 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)




% --- Executes during object creation, after setting all properties.
function Panel_QuiescenceAnalysis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Panel_QuiescenceAnalysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called




% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[FileName PathName] = uigetfile( ...
    {'*.mat'});

myData=load([PathName FileName]);
imagesc(myData.ActVal,[0 500])

handles.TimePImg=myData.TimepImg;
handles.Activity=myData.ActVal;
guidata(hObject,handles);


% --- Executes on button press in pushbutton30.
function pushbutton30_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fields={'Start Frame','End Frame','Quiescence Threshold','Moving Window Duration (s)'};
try
    Ans = inputdlg(fields,'Set Parameters',1,{num2str(handles.NumStart),num2str(handles.NumEnd),num2str(handles.QThresh),num2str(handles.MovingWindowDur)});
catch
    Ans = inputdlg(fields,'Set Parameters',1,{'1','20000','1','600'});
end
NumStart = str2num(Ans{1});
NumEnd = str2num(Ans{2});
QThresh = str2num(Ans{3});
MovingWindowDur = str2num(Ans{4});

% Save Data
handles.NumStart = NumStart;
handles.NumEnd = NumEnd;
handles.QThresh = QThresh;
handles.MovingWindowDur = (MovingWindowDur)/(handles.TimePImg)+1;


axes(handles.axes3)

imagesc(handles.Activity(:,handles.NumStart:handles.NumEnd),[0 500])

guidata(hObject,handles);



% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    [Foq time ActN] = fracQ(handles.Activity(:,handles.NumStart:handles.NumEnd)',handles.QThresh,handles.TimePImg,handles.MovingWindowDur);
catch
    [Foq time ActN] = fracQ(handles.Activity(:,handles.NumStart:handles.NumEnd),handles.QThresh,handles.TimePImg,handles.MovingWindowDur);
end
axes(handles.axes3)
imagesc(time,1:48,ActN',[0 500])
xlabel('Time (hours)')
ylabel('Worm #')

axes(handles.axes4)
imagesc(time,1:48,Foq')
xlabel('Time (hours)')
ylabel('Worm #')

handles.Foq=Foq;
handles.ActN=ActN;
handles.time=time;

guidata(hObject,handles);


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in pushbutton32.
function pushbutton32_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Ans = inputdlg({sprintf('Group regions of interest by genotype\n1. Do not group \n2. Flag pattern\n3. Manual Selection')},'Genotype grouping',1,{'1'});
SelectMethod = str2num(Ans{1});
handles.grouping=str2num(Ans{1});

switch SelectMethod
    case 1
        m1=[1:24];
    case 2
        m1=[1 3 5 7 10 12 14 16 17 19 21 23 26 28 30 32 33 35 37 39 42 44 46 48];
        m2=[1:48]; m2(m1)=[];
    case 3
        m1=[input('Please list the regions of interest corresponding to genotype 1 (e.g. [1 2 3 4] or [1:2:48]): ')];
        m2=[input('Please list the regions of interest corresponding to genotype 2 (e.g. [1 2 3 4] or [1:2:48]): ')];
end

ee=0;
while ee==0;
    axes(handles.axes4)
    imagesc(handles.Foq(:,m1)')
    display('Please select rows to delete for genotype 1.  When finished press enter')
    [d1x d1y]=ginput;
    d1=round(d1y);

    m1t=m1; m1t(d1)=[];
    imagesc(handles.Foq(:,m1t)')
    ee=input('Are you happy with the regions you chose to delete for genotype 1? Input 1 if yes and 0 if no:  ');
    handles.d1 = d1;
    m1(d1)=[];
end

if handles.grouping~=1
    ee=0;
    while ee==0;

        imagesc(handles.Foq(:,m2)')
        display('Please select rows to delete for genotype 2.  When finished press enter')
        [d2x d2y]=ginput;
        d2=round(d2y);

        m2t=m2; m2t(d2)=[];
        imagesc(handles.Foq(:,m2t)')
        ee=input('Are you happy with the regions you chose to delete for genotype 2? Input 1 if yes and 0 if no:  ');
    end
    handles.d2 = d2;
    m2(d2)=[];
end






handles.m1=m1;
MA1=handles.Foq(:,m1);
PA1=handles.ActN(:,m1);
time=handles.time;

if handles.grouping~=1
    handles.m2=m2;
    MA2=handles.Foq(:,m2);
    PA2=handles.ActN(:,m2);
end




ee=input('Do you want to save your unaligned fraction of quiescence data?  Input 1 if yes and 0 if no.  You do not need to save right now if you are going to digitally align your data.  ');

if ee==1
    [SaveName SavePath] = uiputfile('.mat','Save Result');
    if handles.grouping~=1
        grouping=0;
        save([SavePath SaveName],'MA1','PA1','time', ...
            'm1','grouping');
    else
        grouping=1;
        save([SavePath SaveName],'MA1','PA1','time','MA2', ...
            'PA2','m1','m2','grouping');
    end
end

guidata(hObject,handles);




% --- Executes on button press in pushbutton33.
function pushbutton33_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


fields={'Number of frames to consider'};
try
    Ans = inputdlg(fields,'Set Parameters',1,{num2str(handles.nl)});
catch
    Ans = inputdlg(fields,'Set Parameters',1,{'65000'});
end
nl = str2num(Ans{1});
handles.nl=nl;


figure;
imagesc(handles.Foq(:,handles.m1)')

M1=zeros(nl,length(handles.m1));
P1=zeros(nl,length(handles.m1));

e=3;
snum=[input('Please list the start times for each ROI in genotype 1 (e.g. [25000 30000 etc.]): ')]
if length(snum)~=length(handles.m1)
    e=1;
elseif max(snum)>(length(handles.Foq)-nl)
    e=2;
else
    e=0;
end

while e~=0
    display(['There is an error in the start times you entered.  The number of start times must equal the number of ROIs (' num2str(length(handles.m1)) ' for genotype 1).  Also make sure the numbers you entered are not larger than the size of the fraction of quiescence matrix.  Please try again. '])
    snum=[input('Please list the start times for each ROI in genotype 1 (e.g. [25000 30000 etc.]): ')]
    if length(snum)~=length(handles.m1)
        e=1;
    elseif max(snum)>(length(handles.Foq)-nl)
        e=2;
    else
        e=0;
    end
end

for i=1:length(handles.m1)
    M1(:,i)=handles.Foq(snum(i):snum(i)+nl-1,handles.m1(i));
    P1(:,i)=handles.ActN(snum(i):snum(i)+nl-1,handles.m1(i));
end
handles.M1=M1(handles.TimePImg:handles.TimePImg:end,:);
handles.P1=P1(handles.TimePImg:handles.TimePImg:end,:);

if handles.grouping~=1
    figure;
    imagesc(handles.Foq(:,handles.m2)')

    M2=zeros(nl,length(handles.m2));
    P2=zeros(nl,length(handles.m2));

    e=3;
    snum=[input('Please list the start times for each ROI in genotype 2 (e.g. [25000 30000 etc.]): ')]
    if length(snum)~=length(handles.m2)
        e=1;
    elseif max(snum)>(length(handles.Foq)-nl)
        e=2;
    else
        e=0;
    end

    while e~=0
        display(['There is an error in the start times you entered.  The number of start times must equal the number of ROIs (' num2str(length(handles.m2)) ' for genotype 2).  Also make sure the numbers you entered are not larger than the size of the fraction of quiescence matrix.  Please try again. '])
        snum=[input('Please list the start times for each ROI in genotype 2 (e.g. [25000 30000 etc.]): ')]
        if length(snum)~=length(handles.m2)
            e=1;
        elseif max(snum)>(length(handles.Foq)-nl)
            e=2;
        else
            e=0;
        end
    end

    for i=1:length(handles.m2)
        M2(:,i)=handles.Foq(snum(i):snum(i)+nl-1,handles.m2(i));
        P2(:,i)=handles.ActN(snum(i):snum(i)+nl-1,handles.m2(i));
    end
    handles.M2=M2(handles.TimePImg:handles.TimePImg:end,:);
    handles.P2=P2(handles.TimePImg:handles.TimePImg:end,:);
end
guidata(hObject,handles);



% --- Executes on button press in pushbutton34.
function pushbutton34_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

nc=xcorr(handles.M1);
if handles.grouping~=1
    cc=xcorr(handles.M2);
end

[sizexc sizeyc]=size(nc);
[sizexq sizeyq]=size(handles.M1);
naligned=zeros(sizexc,sizeyc);
npa=zeros(sizexc,sizeyc);


[m mi]=max(nc,[],1);
delay=mi-sizexq;
for i=1:sizeyq
    for j=1:sizeyq
        naligned([delay(sizeyq*(i-1)+j)+1:sizexq+delay(sizeyq*(i-1)+j)]-min(delay),sizeyq*(i-1)+j)=[handles.M1(:,j)];
        npa([delay(sizeyq*(i-1)+j)+1:sizexq+delay(sizeyq*(i-1)+j)]-min(delay),sizeyq*(i-1)+j)=[handles.P1(:,j)];
    end
end

if handles.grouping~=1
    [sizexc sizeyc]=size(cc);
    [sizexq sizeyq]=size(handles.M2);
    caligned=zeros(sizexc,sizeyc);
    cpa=zeros(sizexc,sizeyc);

    [m mi]=max(cc,[],1);
    delay=mi-sizexq;
    for i=1:sizeyq
        for j=1:sizeyq
            caligned([delay(sizeyq*(i-1)+j)+1:sizexq+delay(sizeyq*(i-1)+j)]-min(delay),sizeyq*(i-1)+j)=[handles.M2(:,j)];
            cpa([delay(sizeyq*(i-1)+j)+1:sizexq+delay(sizeyq*(i-1)+j)]-min(delay),sizeyq*(i-1)+j)=[handles.P2(:,j)];
        end
    end

    MA2=caligned(:,1:length(handles.m2));
    PA2=cpa(:,1:length(handles.m2));
    t2=[1:length(MA2)]*handles.TimePImg/3600;
    [sizey2 sizex2]=size(MA2);
end

MA1=naligned(:,1:length(handles.m1));
PA1=npa(:,1:length(handles.m1));
t1=[1:length(MA1)]*handles.TimePImg/3600;


[sizey1 sizex1]=size(MA1);


axes(handles.axes4)
imagesc(t1,1:sizex1,MA1')
xlabel('Time (hours)')
ylabel('Worm #')

if handles.grouping~=1
    axes(handles.axes8)
    imagesc(t2,1:sizex2,MA2')
    xlabel('Time (hours)')
    ylabel('Worm #')
end

ee=input('Would you like to save? Input 1 if yes and 0 if no:  ');

if handles.grouping==1
    grouping=0;
    if ee==1
        m1=handles.m1;
        [SaveName SavePath] = uiputfile('.mat','Save Result');
        save([SavePath SaveName],'MA1','PA1','t1', ...
            'm1','grouping');
    end
else
    grouping=1;
    if ee==1
        [SaveName SavePath] = uiputfile('.mat','Save Result');
        save([SavePath SaveName],'MA1','PA1','t1','MA2', ...
            'PA2','t2','grouping');
    end
end

% --- Executes on button press in pushbutton35.
function pushbutton35_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



[FileName PathName] = uigetfile( ...
    {'*.mat'});
myData=load([PathName FileName]);

alignedYN=input('Please input 1 if you loaded digitally aligned data.  Please input 0 if you loaded unaligned data:  ');

handles.aligned=alignedYN;
handles.grouping=myData.grouping;

[sizey1 sizex1]=size(myData.MA1);

if handles.grouping == 1
    [sizey2 sizex2]=size(myData.MA2);
end

if alignedYN==1;
    axes(handles.axes6)
    imagesc(myData.t1,1:sizex1,myData.MA1')
    xlabel('Time (hours)')
    ylabel('Worm #')

    if handles.grouping == 1
        axes(handles.axes7)
        imagesc(myData.t2,1:sizex2,myData.MA2')
        xlabel('Time (hours)')
        ylabel('Worm #')

        handles.MA2=myData.MA2;
        handles.PA2=myData.PA2;
        handles.t2=myData.t2;
    end

    handles.MA1=myData.MA1;
    handles.PA1=myData.PA1;
    handles.t1=myData.t1;
else
    axes(handles.axes6)
    imagesc(myData.time,1:sizex1,myData.MA1')
    xlabel('Time (hours)')
    ylabel('Worm #')

    if handles.grouping == 1
        axes(handles.axes7)
        imagesc(myData.time,1:sizex2,myData.MA2')
        xlabel('Time (hours)')
        ylabel('Worm #')

        handles.MA2=myData.MA2;
        handles.PA2=myData.PA2;
    end

    handles.MA1=myData.MA1;
    handles.PA1=myData.PA1;
    handles.t1=myData.time;

end


guidata(hObject,handles);



% --- Executes on button press in pushbutton36.
function pushbutton36_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes4)
imagesc(handles.Foq(:,handles.m1)')

display('Choose a region of interest with clear quiescence peaks')
[nxt nyt]=ginput(1);

plot(handles.Foq(:,handles.m1(round(nyt))))

display('Please select start and end time.  The start time should be before the L3 lethargus quiescence peak and the end time should be after the L4 lethargus quiescence peak.')
[nxt nyt]=ginput(2);
nl=round(abs(nxt(2)-nxt(1)));
handles.nl=nl;

ee=0;
while ee==0

    display('Please select the start time for each region of interest for genotype 1:')
    for j=1:length(handles.m1)
        plot(handles.Foq(:,handles.m1(j)))
        [snumx(j) snumy(j)]=ginput(1);
    end
    snumx=round(snumx);

    for i=1:length(handles.m1)
        M1(:,i)=handles.Foq(snumx(i):snumx(i)+nl-1,handles.m1(i));
        P1(:,i)=handles.ActN(snumx(i):snumx(i)+nl-1,handles.m1(i));
    end
    handles.M1=M1(handles.TimePImg:handles.TimePImg:end,:);
    handles.P1=P1(handles.TimePImg:handles.TimePImg:end,:);

    imagesc(M1')
    ee=input('Are you happy with manual alignment for genotype 1?  Input 1 for yes and 0 for no:  ');
end

if handles.grouping~=1
    ee=0;
    while ee==0

        display('Please select the start time for each region of interest for genotype 2:')

        for j=1:length(handles.m2)
            plot(handles.Foq(:,handles.m2(j)))
            [snumx2(j) snumy2(j)]=ginput(1);
        end
        snumx2=round(snumx2);
        for i=1:length(handles.m2)
            M2(:,i)=handles.Foq(snumx2(i):snumx2(i)+nl-1,handles.m2(i));
            P2(:,i)=handles.ActN(snumx2(i):snumx2(i)+nl-1,handles.m2(i));
        end
        handles.M2=M2(handles.TimePImg:handles.TimePImg:end,:);
        handles.P2=P2(handles.TimePImg:handles.TimePImg:end,:);

        imagesc(M2')
        ee=input('Are you happy with manual alignment for genotype 2?  Input 1 for yes and 0 for no:  ');
    end
end

guidata(hObject,handles);


% --- Executes on button press in pushbutton37.
function pushbutton37_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

spi=3600*(handles.t1(2)-handles.t1(1));
fields={'Fraction of quiescence threshold','Quiescence Threshold','Genotype 1 Strain Name','Genotype 2 Strain Name'};
try
    Ans = inputdlg(fields,'Set Parameters',1,{num2str(handles.foqt),num2str(handles.QThresh),handles.name1,handles.name2});
catch
    Ans = inputdlg(fields,'Set Parameters',1,{'0.25','1','N2',''});
end
foqt = str2num(Ans{1});
QThresh = str2num(Ans{2});
name1=Ans{3};
name2=Ans{4};

% Save Data
handles.foqt = foqt;
handles.QThresh = QThresh;
handles.name1=name1;
handles.name2=name2;

[sizey1 sizex1]=size(handles.MA1);

if handles.grouping == 1
    [sizey2 sizex2]=size(handles.MA2);
end

axes(handles.axes6)
imagesc(handles.MA1')

if handles.grouping == 1
    axes(handles.axes7)
    imagesc(handles.MA2')
end

display('Please select the start time and end time to quantify quiescence in for genotype 1:  ');
[timex1 y]=ginput(2);
dt=timex1(2)-timex1(1);
n2l=round(timex1(1)):round(timex1(2));

if handles.grouping == 1
    display('Please select the start time to quantify quiescence in for genotype 2:  ');
    [timex2 y]=ginput(1);
    k2l=round(timex2(1)):round(timex2(1)+dt);
end

display('Please select the start time and end time to quantify activity in for genotype 1:  ');
[timex1 y]=ginput(2);
dt=timex1(2)-timex1(1);
n2l2=round(timex1(1)):round(timex1(2));

if handles.grouping == 1
    display('Please select the start time to quantify activity in for genotype 2:  ');
    [timex2 y]=ginput(1);
    k2l2=round(timex2(1)):round(timex2(1)+dt);
end

PN2=handles.PA1(n2l2,:);
nta=mean(PN2);
handles.nta=nta;

if handles.grouping == 1
    PK2=handles.PA2(k2l2,:);
    kta=mean(PK2);
    handles.kta=kta;
end

for i=1:(sizex1)
    nq(:,i)=handles.MA1(:,i)>foqt*max(handles.MA1(:,i));
end
np=handles.PA1<QThresh;
ntq=sum(nq(n2l,:).*np(n2l,:))*spi/60;
handles.ntq=ntq;
[l4duration1 letpeaks1] = l4Dur(handles.MA1,7,handles.t1);
handles.l4duration1 = l4duration1;
handles.letpeaks1 = letpeaks1;

if handles.grouping == 1
    for i=1:(sizex2)
        kq(:,i)=handles.MA2(:,i)>foqt*max(handles.MA2(:,i));
    end
    kp=handles.PA2<QThresh;
    ktq=sum(kq(k2l,:).*kp(k2l,:))*spi/60;
    handles.ktq=ktq;

    [l4duration2 letpeaks2] = l4Dur(handles.MA2,7,handles.t1);
    handles.l4duration2 = l4duration2;
    handles.letpeaks2 = letpeaks2;
end

if handles.grouping == 1
    axes(handles.axes9)
    bar(1,mean(ntq),'FaceColor',[1 1 1])
    hold on
    bar(2,mean(ktq),'FaceColor',[0.2 0.1 0.4])
    errorbar([1 2], [mean(ntq) mean(ktq)],[std(ntq)/sqrt(length(ntq)) std(ktq)/sqrt(length(ktq))],'k.','MarkerSize',1,'LineWidth',5)
    ylabel('Quiescence (minutes)')
    set(gca,'XTick',[1:2])
    set(gca,'XTickLabel',{name1,name2})
    %set(findall(gcf,'-property','FontSize'),'FontSize',20)
    box off
    [a q c]=ttest2(ntq,ktq);
    text(1.5, 1.2*mean(ntq),['p value = ' num2str(q)])

    axes(handles.axes10)
    bar(1,mean(nta),'FaceColor',[ 1 1 1])
    hold on
    bar(2,mean(kta),'FaceColor',[0.2 0.1 0.4])
    errorbar([1 2], [mean(nta) mean(kta)],[std(nta)/sqrt(length(nta)) std(kta)/sqrt(length(kta))],'k.','MarkerSize',1,'LineWidth',5)
    ylabel('Activity')
    set(gca,'XTick',[1:2])
    set(gca,'XTickLabel',{name1,name2})
    %set(findall(gcf,'-property','FontSize'),'FontSize',20)
    box off
    [b a c]=ttest2(nta,kta);
    text(1.5, 1.2*mean(nta),['p value = ' num2str(a)])
end

guidata(hObject,handles);

% --- Executes on button press in pushbutton38.
function pushbutton38_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.Panel_Preview,'visible','off')
set(handles.Panel_ActivityAnalysis,'visible','off')
set(handles.Panel_QuiescenceAnalysis,'visible','off')
set(handles.Panel_PlotData,'visible','off')
set(handles.ActivityAnalyze,'visible','on')
axes(handles.axes12)
set(handles.axes12,'visible','on')

% --- Executes on button press in pushbutton39.
function pushbutton39_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


[FileName PathName] = uigetfile({'*.mat'});

myData=load([PathName FileName]);
imagesc(myData.ActVal)

handles.TimePImg=myData.TimepImg;
handles.Activity=myData.ActVal;
guidata(hObject,handles);


%
% --- Executes during object creation, after setting all properties.
function Panel_ActivityAnalysis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Panel_ActivityAnalysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called




% --- Executes on button press in pushbutton41.
function pushbutton41_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tosave=handles.Activity;
[xsize ysize]=size(tosave)
times=[1:ysize]*handles.TimePImg;
[SaveName SavePath] = uiputfile('.csv','Save Result');
csvwrite([SavePath SaveName],[times' tosave']);




% --- Executes on button press in pushbutton42.
function pushbutton42_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Ans = inputdlg({sprintf('Save Method\n1. CSV File (MS Excel Compatible) \n2. Mat file (Matlab Compatible)\n')},'Genotype grouping',1,{'1'});
SelectMethod = str2num(Ans{1});

switch SelectMethod
    case 1
        if handles.grouping==0
            tosaveQ=[handles.ntq];
            tosaveA=[handles.nta];
            genotype=handles.m1;
            L4Duration=handles.l4duration1;
            LethargusPeaks=handles.letpeaks1;
            [SaveName SavePath] = uiputfile('.csv','Save Result');
            csvwrite([SavePath SaveName],[tosaveQ' tosaveA' genotype' L4Duration' LethargusPeaks']);
        else
            display('hi')
            tosaveQ=[handles.ntq handles.ktq];
            tosaveA=[handles.nta handles.kta];
            genotype=[handles.m1 handles.m2];
            what=handles.letpeaks1
            L4Duration=[handles.l4duration1' handles.l4duration2'];
            % LethargusPeaks=[handles.letpeaks1 handles.letpeaks2];
            [SaveName SavePath] = uiputfile('.csv','Save Result');
            % csvwrite([SavePath SaveName],[tosaveQ' tosaveA' genotype' L4Duration' LethargusPeaks']);
            csvwrite([SavePath SaveName],[tosaveQ' tosaveA' genotype' L4Duration']);
        end
    case 2
        if handles.grouping==0
            tosaveQ=[handles.ntq];
            tosaveA=[handles.nta];
            genotype=handles.m1;
            L4Duration=handles.l4duration1;
            LethargusPeaks = handles.letpeaks1;
            QuiescenceMatrix=handles.MA1;
            [SaveName SavePath] = uiputfile('.mat','Save Result');
            save([SavePath SaveName],'tosaveQ','tosaveA','genotype','L4Duration','LethargusPeaks','QuiescenceMatrix');
        else
            tosaveQ=[handles.ntq handles.ktq];
            tosaveA=[handles.nta handles.kta];
            genotype=[handles.m1 handles.m2];
            L4Duration=[handles.l4duration1' handles.l4duration2'];
            %LethargusPeaks = [handles.letpeaks1 handles.letpeaks2];
            [SaveName SavePath] = uiputfile('.mat','Save Result');
            %csvwrite([SavePath SaveName],'tosaveQ','tosaveA','genotype','L4Duration','LethargusPeaks');
           save([SavePath SaveName],'tosaveQ','tosaveA','genotype','L4Duration');
        end
end

