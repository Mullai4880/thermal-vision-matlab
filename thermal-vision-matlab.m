function thermal_vision_enhanced()
    %% THERMAL VISION SIMULATOR (Enhanced Version)
    % Creates a GUI application that converts regular images to thermal vision style
    % with multiple enhancement options and analysis tools
    
    %% Initialize main figure
    fig = figure('Name', 'Enhanced Thermal Vision Simulator', ...
                'Position', [100 100 1200 700], ...
                'MenuBar', 'none', ...
                'NumberTitle', 'off', ...
                'Color', [0.2 0.2 0.2]);
    
    %% Create Control Panel
    controlPanel = uipanel('Parent', fig, ...
                          'Position', [0.02 0.02 0.2 0.96], ...
                          'Title', 'Controls', ...
                          'ForegroundColor', 'white', ...
                          'BackgroundColor', [0.3 0.3 0.3]);
    
    %% Create UI Controls
    % Starting positions
    yPos = 550;
    buttonWidth = 120;
    buttonHeight = 30;
    spacing = 40;
    
    % Load Image Button
    uicontrol('Parent', controlPanel, ...
             'Style', 'pushbutton', ...
             'String', 'Load Image', ...
             'Position', [20 yPos buttonWidth buttonHeight], ...
             'Callback', @loadImage);
    
    yPos = yPos - spacing;
    
    % Colormap Selection
    uicontrol('Parent', controlPanel, ...
             'Style', 'text', ...
             'String', 'Thermal Colormap:', ...
             'Position', [20 yPos buttonWidth 20], ...
             'ForegroundColor', 'white', ...
             'BackgroundColor', [0.3 0.3 0.3]);
    
    yPos = yPos - 25;
    
    % Colormap Dropdown
    uicontrol('Parent', controlPanel, ...
             'Style', 'popupmenu', ...
             'String', {'hot', 'jet', 'parula', 'turbo', 'winter', 'summer', 'copper'}, ...
             'Position', [20 yPos buttonWidth 25], ...
             'Callback', @updateColormap);
    
    yPos = yPos - spacing;
    
    % Enhancement Options
    uicontrol('Parent', controlPanel, ...
             'Style', 'text', ...
             'String', 'Enhancement:', ...
             'Position', [20 yPos buttonWidth 20], ...
             'ForegroundColor', 'white', ...
             'BackgroundColor', [0.3 0.3 0.3]);
    
    yPos = yPos - 25;
    
    % Enhancement Dropdown
    uicontrol('Parent', controlPanel, ...
             'Style', 'popupmenu', ...
             'String', {'None', 'Histogram Equalization', 'Contrast Stretch', 'Adaptive Equalization'}, ...
             'Position', [20 yPos buttonWidth 25], ...
             'Callback', @applyEnhancement);
    
    yPos = yPos - spacing;
    
    % Temperature Scale Toggle
    uicontrol('Parent', controlPanel, ...
             'Style', 'checkbox', ...
             'String', 'Show Temperature Scale', ...
             'Position', [20 yPos buttonWidth 25], ...
             'Value', 1, ...
             'Callback', @toggleTempScale, ...
             'ForegroundColor', 'white', ...
             'BackgroundColor', [0.3 0.3 0.3]);
    
    yPos = yPos - spacing;
    
    % Histogram Button
    uicontrol('Parent', controlPanel, ...
             'Style', 'pushbutton', ...
             'String', 'Show Histogram', ...
             'Position', [20 yPos buttonWidth buttonHeight], ...
             'Callback', @showHistogram);
    
    yPos = yPos - spacing;
    
    % Export Button
    uicontrol('Parent', controlPanel, ...
             'Style', 'pushbutton', ...
             'String', 'Export Image', ...
             'Position', [20 yPos buttonWidth buttonHeight], ...
             'Callback', @exportImage);
    
    %% Create Display Areas
    % Original Image Display
    ax1 = subplot('Position', [0.25 0.1 0.35 0.8]);
    title('Original Image', 'Color', 'white');
    set(ax1, 'Color', 'black');
    
    % Thermal Image Display
    ax2 = subplot('Position', [0.65 0.1 0.35 0.8]);
    title('Thermal Vision', 'Color', 'white');
    set(ax2, 'Color', 'black');
    
    % Store handles and initialize data
    setappdata(fig, 'Axes1', ax1);
    setappdata(fig, 'Axes2', ax2);
    setappdata(fig, 'ShowTempScale', true);
    
    %% Callback Functions
    function loadImage(~, ~)
        try
            [filename, pathname] = uigetfile({'*.jpg;*.png;*.bmp', 'Image Files (*.jpg,*.png,*.bmp)'});
            if filename == 0
                return;
            end
            
            % Load and convert image
            I = imread(fullfile(pathname, filename));
            if size(I,3) == 3
                I = rgb2gray(I);
            end
            
            % Store original image
            setappdata(fig, 'OriginalImage', I);
            
            % Process and display
            processAndDisplayImage(I);
            
        catch ME
            errordlg(['Error loading image: ' ME.message], 'Error');
        end
    end
    
    function processAndDisplayImage(I)
        try
            % Get axes handles
            ax1 = getappdata(fig, 'Axes1');
            ax2 = getappdata(fig, 'Axes2');
            
            % Clear existing images
            cla(ax1);
            cla(ax2);
            
            % Display original
            imshow(I, [], 'Parent', ax1);
            title(ax1, 'Original Image', 'Color', 'white');
            
            % Normalize image
            I_norm = double(I);
            I_norm = (I_norm - min(I_norm(:))) / (max(I_norm(:)) - min(I_norm(:)));
            
            % Display thermal
            imshow(I_norm, [], 'Parent', ax2);
            title(ax2, 'Thermal Vision', 'Color', 'white');
            
            % Apply current colormap
            colormap(ax2, 'hot');
            
            % Add temperature scale if enabled
            if getappdata(fig, 'ShowTempScale')
                addTemperatureScale(ax2, I_norm);
            end
            
        catch ME
            errordlg(['Error processing image: ' ME.message], 'Error');
        end
    end
    
    function updateColormap(src, ~)
        try
            % Get selected colormap
            maps = {'hot','jet','parula','turbo','winter','summer','copper'};
            selected_map = maps{src.Value};
            
            % Get thermal image axes
            ax2 = getappdata(fig, 'Axes2');
            
            % Check if image exists
            current_image = findobj(ax2, 'Type', 'image');
            if isempty(current_image)
                errordlg('Please load an image first.', 'Error');
                return;
            end
            
            % Apply new colormap
            colormap(ax2, selected_map);
            
            % Update temperature scale if enabled
            if getappdata(fig, 'ShowTempScale')
                addTemperatureScale(ax2, current_image.CData);
            end
            
        catch ME
            errordlg(['Error updating colormap: ' ME.message], 'Error');
        end
    end
    
    function applyEnhancement(src, ~)
        try
            if ~isappdata(fig, 'OriginalImage')
                errordlg('Please load an image first.', 'Error');
                return;
            end
            
            % Get original image
            I = getappdata(fig, 'OriginalImage');
            I = double(I); % Convert to double for processing
            
            % Apply enhancement
            switch src.Value
                case 1 % None
                    enhanced = I;
                case 2 % Histogram Equalization
                    enhanced = customHistEq(I);
                case 3 % Contrast Stretch
                    enhanced = contrastStretch(I);
                case 4 % Adaptive Equalization
                    enhanced = adaptiveEqualization(I);
            end
            
            % Convert back to uint8 for display
            enhanced = uint8(enhanced);
            
            % Update display
            processAndDisplayImage(enhanced);
            
        catch ME
            errordlg(['Error applying enhancement: ' ME.message], 'Error');
        end
    end
    
    function enhanced = customHistEq(img)
        % Custom histogram equalization
        img = double(img);
        
        % Get histogram
        [counts, ~] = histcounts(img(:), 256);
        
        % Calculate cumulative distribution
        cdf = cumsum(counts) / numel(img);
        
        % Create lookup table
        lut = round(255 * cdf);
        
        % Apply lookup table
        enhanced = zeros(size(img));
        for i = 1:256
            mask = (img >= (i-1)) & (img < i);
            enhanced(mask) = lut(i);
        end
        
        % Ensure output range is [0, 255]
        enhanced = max(0, min(255, enhanced));
    end
    
    function enhanced = contrastStretch(img)
        % Simple contrast stretching
        img = double(img);
        
        % Find min and max values
        minVal = min(img(:));
        maxVal = max(img(:));
        
        % Perform linear stretch to [0, 255]
        if maxVal > minVal
            enhanced = 255 * (img - minVal) / (maxVal - minVal);
        else
            enhanced = img;
        end
    end
    
    function enhanced = adaptiveEqualization(img)
        % Simplified adaptive histogram equalization
        img = double(img);
        [rows, cols] = size(img);
        enhanced = zeros(size(img));
        
        % Define block size
        blockSize = [round(rows/4), round(cols/4)];
        
        % Process each block
        for i = 1:4
            for j = 1:4
                % Calculate block bounds
                rowStart = 1 + (i-1)*blockSize(1);
                rowEnd = min(i*blockSize(1), rows);
                colStart = 1 + (j-1)*blockSize(2);
                colEnd = min(j*blockSize(2), cols);
                
                % Extract and enhance block
                block = img(rowStart:rowEnd, colStart:colEnd);
                enhanced(rowStart:rowEnd, colStart:colEnd) = customHistEq(block);
            end
        end
    end
    
    function toggleTempScale(src, ~)
        try
            % Update temperature scale visibility
            setappdata(fig, 'ShowTempScale', src.Value);
            
            % Get thermal image axes
            ax2 = getappdata(fig, 'Axes2');
            
            % Toggle temperature scale
            if ~src.Value
                colorbar(ax2, 'off');
            else
                current_image = findobj(ax2, 'Type', 'image');
                if ~isempty(current_image)
                    addTemperatureScale(ax2, current_image.CData);
                end
            end
            
        catch ME
            errordlg(['Error toggling temperature scale: ' ME.message], 'Error');
        end
    end
    
    function addTemperatureScale(ax, ~)
        % Add colorbar
        c = colorbar(ax);
        c.Label.String = 'Temperature Scale (°C)';
        c.Label.Color = 'white';
        c.Color = 'white';
        
        % Set temperature range
        minTemp = 20;  % 20°C
        maxTemp = 40;  % 40°C
        
        % Update ticks
        c.Ticks = linspace(0, 1, 5);
        c.TickLabels = arrayfun(@(x) sprintf('%.1f°C', x), ...
            linspace(minTemp, maxTemp, 5), 'UniformOutput', false);
    end
    
    function showHistogram(~, ~)
        try
            if ~isappdata(fig, 'OriginalImage')
                errordlg('Please load an image first.', 'Error');
                return;
            end
            
            % Create histogram figure
            histFig = figure('Name', 'Image Histogram', ...
                           'Position', [200 200 600 400]);
            
            % Get image and plot histogram
            I = getappdata(fig, 'OriginalImage');
            histogram(double(I(:)), 256, 'EdgeColor', 'none');
            title('Image Intensity Histogram');
            xlabel('Intensity Value');
            ylabel('Frequency');
            grid on;
            
        catch ME
            errordlg(['Error showing histogram: ' ME.message], 'Error');
        end
    end
    
    function exportImage(~, ~)
        try
            if ~isappdata(fig, 'OriginalImage')
                errordlg('Please load an image first.', 'Error');
                return;
            end
            
            % Get thermal image
            ax2 = getappdata(fig, 'Axes2');
            frame = getframe(ax2);
            thermalImage = frame.cdata;
            
            % Save dialog
            [filename, pathname] = uiputfile({'*.png','PNG File (*.png)';
                                            '*.jpg','JPEG File (*.jpg)';
                                            '*.tif','TIFF File (*.tif)'}, ...
                                           'Save Thermal Image As');
            if filename == 0
                return;
            end
            
            % Save image
            imwrite(thermalImage, fullfile(pathname, filename));
            msgbox('Image exported successfully!', 'Success');
            
        catch ME
            errordlg(['Error exporting image: ' ME.message], 'Error');
        end
    end
end
