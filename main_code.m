classdef app < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure          matlab.ui.Figure
        DJMixerPanel      matlab.ui.container.Panel
        play              matlab.ui.control.Button
        BEAT2Button       matlab.ui.control.Button
        BEAT1Button       matlab.ui.control.Button
        VolumeKnobLabel   matlab.ui.control.Label
        VolumeKnob        matlab.ui.control.Knob
        STOPButton        matlab.ui.control.Button
        RECButton         matlab.ui.control.Button
        BBOXButton_2      matlab.ui.control.Button
        SpeedSliderLabel  matlab.ui.control.Label
        SpeedSlider       matlab.ui.control.Slider
        UIAxes            matlab.ui.control.UIAxes
        UIAxes2           matlab.ui.control.UIAxes
        UIAxes4           matlab.ui.control.UIAxes
    end


    properties (Access = private)
        fs=44100;
        recObj;
        recy;
        signal; 
        Fs;
        y;  
        signal2;
        y1;
    end

  


    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: play
        function playButton(app, event)
            [app.y,app.Fs]=audioread('D:\STUDY\大二下\訊號與系統\期中報告\音檔\如果我是DJ 你會愛我嗎.mp3');
            sound(app.y*app.VolumeKnob.Value,app.Fs*app.SpeedSlider.Value);
            %amp
            app.signal=app.y*app.VolumeKnob.Value;
            time = (1:length(app.signal))/app.Fs*app.SpeedSlider.Value;
            plot(app.UIAxes, time, app.signal);

            %player = audioplayer(y,Fs*app.VolumeKnob.Value);
            %play(player);
            %assignin('base','player', player);
        end

        % Button pushed function: BEAT2Button
        function BEAT2ButtonPushed(app, event)
            [app.y,app.Fs] = audioread('D:\STUDY\大二下\訊號與系統\期中報告\音檔\storm.mp3');
            sound(app.y*app.VolumeKnob.Value,app.Fs*app.SpeedSlider.Value);
            %amp
            app.signal=app.y*app.VolumeKnob.Value;
            time = (1:length(app.signal))/app.Fs*app.SpeedSlider.Value;
            plot(app.UIAxes2, time, app.signal);
        end

        % Callback function
        function StopButtonPushed(app, event)
            player=evalin('base', 'player');
            stop(player);
        end

        % Button pushed function: BEAT1Button
        function BEAT1ButtonPushed(app, event)
            [app.y,app.Fs] = audioread('D:\STUDY\大二下\訊號與系統\期中報告\音檔\Firefly drum.mp3');
            sound(app.y*app.VolumeKnob.Value,app.Fs*app.SpeedSlider.Value);
            %amp
            app.signal=app.y*app.VolumeKnob.Value;
            time = (1:length(app.signal))/app.Fs*app.SpeedSlider.Value;
            plot(app.UIAxes2, time, app.signal);
            %play(Drum);
            %assignin('base','Drum', Drum);
        end

        % Button pushed function: STOPButton
        function STOPButtonPushed(app, event)
            clear sound;
        end

        % Button pushed function: RECButton
        function RECButtonPushed(app, event)
            app.recObj=  audiorecorder;
            recordblocking(app.recObj,5);  
        end

        % Button pushed function: BBOXButton_2
        function BBOXButton_2Pushed(app, event)
            app.recy=getaudiodata(app.recObj);  
            plot(app.UIAxes4,app.recy);
            play(app.recObj);
            pause(5);
        end

        % Value changed function: SpeedSlider
        function SpeedSliderValueChanged(app, event)
            value = app.SpeedSlider.Value;
            
        end

        % Size changed function: DJMixerPanel
        function DJMixerPanelSizeChanged(app, event)
            position = app.DJMixerPanel.Position;
            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 746 575];
            app.UIFigure.Name = 'UI Figure';

            % Create DJMixerPanel
            app.DJMixerPanel = uipanel(app.UIFigure);
            app.DJMixerPanel.ForegroundColor = [1 1 1];
            app.DJMixerPanel.TitlePosition = 'centertop';
            app.DJMixerPanel.Title = 'DJ Mixer';
            app.DJMixerPanel.BackgroundColor = [0 0 0];
            app.DJMixerPanel.SizeChangedFcn = createCallbackFcn(app, @DJMixerPanelSizeChanged, true);
            app.DJMixerPanel.FontName = 'Arial';
            app.DJMixerPanel.FontWeight = 'bold';
            app.DJMixerPanel.FontSize = 48;
            app.DJMixerPanel.Position = [1 15 771 561];

            % Create play
            app.play = uibutton(app.DJMixerPanel, 'push');
            app.play.ButtonPushedFcn = createCallbackFcn(app, @playButton, true);
            app.play.FontSize = 24;
            app.play.FontWeight = 'bold';
            app.play.FontColor = [0 0 1];
            app.play.Position = [20 406 138 42];
            app.play.Text = 'PLAY';

            % Create BEAT2Button
            app.BEAT2Button = uibutton(app.DJMixerPanel, 'push');
            app.BEAT2Button.ButtonPushedFcn = createCallbackFcn(app, @BEAT2ButtonPushed, true);
            app.BEAT2Button.FontSize = 24;
            app.BEAT2Button.FontWeight = 'bold';
            app.BEAT2Button.FontColor = [0 0.451 0.7412];
            app.BEAT2Button.Position = [207 185 138 43];
            app.BEAT2Button.Text = 'BEAT2';

            % Create BEAT1Button
            app.BEAT1Button = uibutton(app.DJMixerPanel, 'push');
            app.BEAT1Button.ButtonPushedFcn = createCallbackFcn(app, @BEAT1ButtonPushed, true);
            app.BEAT1Button.FontSize = 24;
            app.BEAT1Button.FontWeight = 'bold';
            app.BEAT1Button.FontColor = [0.6392 0.0784 0.1804];
            app.BEAT1Button.Position = [207 251 138 43];
            app.BEAT1Button.Text = 'BEAT1';

            % Create VolumeKnobLabel
            app.VolumeKnobLabel = uilabel(app.DJMixerPanel);
            app.VolumeKnobLabel.HorizontalAlignment = 'center';
            app.VolumeKnobLabel.VerticalAlignment = 'top';
            app.VolumeKnobLabel.FontSize = 16;
            app.VolumeKnobLabel.FontWeight = 'bold';
            app.VolumeKnobLabel.FontColor = [0.8 0.8 0.8];
            app.VolumeKnobLabel.Position = [62 112 62 20];
            app.VolumeKnobLabel.Text = 'Volume';

            % Create VolumeKnob
            app.VolumeKnob = uiknob(app.DJMixerPanel, 'continuous');
            app.VolumeKnob.Limits = [0 10];
            app.VolumeKnob.FontSize = 16;
            app.VolumeKnob.FontWeight = 'bold';
            app.VolumeKnob.FontColor = [0.8 0.8 0.8];
            app.VolumeKnob.Position = [54 166 78 78];
            app.VolumeKnob.Value = 1;

            % Create STOPButton
            app.STOPButton = uibutton(app.DJMixerPanel, 'push');
            app.STOPButton.ButtonPushedFcn = createCallbackFcn(app, @STOPButtonPushed, true);
            app.STOPButton.FontSize = 24;
            app.STOPButton.FontWeight = 'bold';
            app.STOPButton.FontColor = [0.4706 0.6706 0.1882];
            app.STOPButton.Position = [207 405 138 43];
            app.STOPButton.Text = 'STOP';

            % Create RECButton
            app.RECButton = uibutton(app.DJMixerPanel, 'push');
            app.RECButton.ButtonPushedFcn = createCallbackFcn(app, @RECButtonPushed, true);
            app.RECButton.FontSize = 24;
            app.RECButton.FontWeight = 'bold';
            app.RECButton.FontColor = [1 0 0];
            app.RECButton.Position = [20 334 138 43];
            app.RECButton.Text = '●REC';

            % Create BBOXButton_2
            app.BBOXButton_2 = uibutton(app.DJMixerPanel, 'push');
            app.BBOXButton_2.ButtonPushedFcn = createCallbackFcn(app, @BBOXButton_2Pushed, true);
            app.BBOXButton_2.FontSize = 24;
            app.BBOXButton_2.FontWeight = 'bold';
            app.BBOXButton_2.FontColor = [0.9294 0.6902 0.1294];
            app.BBOXButton_2.Position = [207 334 138 43];
            app.BBOXButton_2.Text = 'BBOX';

            % Create SpeedSliderLabel
            app.SpeedSliderLabel = uilabel(app.DJMixerPanel);
            app.SpeedSliderLabel.HorizontalAlignment = 'right';
            app.SpeedSliderLabel.VerticalAlignment = 'top';
            app.SpeedSliderLabel.FontSize = 16;
            app.SpeedSliderLabel.FontWeight = 'bold';
            app.SpeedSliderLabel.FontColor = [0.8 0.8 0.8];
            app.SpeedSliderLabel.Position = [27 55 54 20];
            app.SpeedSliderLabel.Text = 'Speed';

            % Create SpeedSlider
            app.SpeedSlider = uislider(app.DJMixerPanel);
            app.SpeedSlider.Limits = [0.5 3];
            app.SpeedSlider.MajorTicks = [0.5 1 1.5 2 2.5 3];
            app.SpeedSlider.ValueChangedFcn = createCallbackFcn(app, @SpeedSliderValueChanged, true);
            app.SpeedSlider.FontSize = 16;
            app.SpeedSlider.FontWeight = 'bold';
            app.SpeedSlider.FontColor = [0.8 0.8 0.8];
            app.SpeedSlider.Position = [102 66 237 3];
            app.SpeedSlider.Value = 1;

            % Create UIAxes
            app.UIAxes = uiaxes(app.DJMixerPanel);
            title(app.UIAxes, 'Main')
            xlabel(app.UIAxes, 'Time(s)')
            ylabel(app.UIAxes, 'amp')
            app.UIAxes.FontWeight = 'bold';
            app.UIAxes.XLim = [0 20];
            app.UIAxes.YLim = [-2 2];
            app.UIAxes.CLim = [0 1];
            app.UIAxes.ColorOrder = [0 0.4471 0.7412;0.851 0.3255 0.098;0.9294 0.6941 0.1255;0.4941 0.1843 0.5569;0.4667 0.6745 0.1882;0.302 0.7451 0.9333;0.6353 0.0784 0.1843];
            app.UIAxes.Position = [383 334 363 137];

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.DJMixerPanel);
            title(app.UIAxes2, 'Drum beats')
            xlabel(app.UIAxes2, 'Time(s)')
            ylabel(app.UIAxes2, 'amp')
            app.UIAxes2.FontWeight = 'bold';
            app.UIAxes2.XLim = [0 20];
            app.UIAxes2.YLim = [-2 2];
            app.UIAxes2.Position = [383 176 363 129];

            % Create UIAxes4
            app.UIAxes4 = uiaxes(app.DJMixerPanel);
            title(app.UIAxes4, 'BBOX')
            xlabel(app.UIAxes4, 'Time(s)')
            ylabel(app.UIAxes4, 'amp')
            app.UIAxes4.FontWeight = 'bold';
            app.UIAxes4.Position = [383 18 363 129];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = app

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end 