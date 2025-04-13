# MATLAB Thermal Vision Simulator

A comprehensive MATLAB application that transforms regular images into thermal vision representations with powerful enhancement capabilities. This tool helps visualize images as if they were captured by a thermal camera, with various processing options to improve visualization.

## Table of Contents
- [Features](#features)
- [How It Works](#how-it-works)
- [Installation](#installation)
- [Step-by-Step Usage Guide](#step-by-step-usage-guide)
- [Understanding Enhancement Options](#understanding-enhancement-options)
- [Examples and Results](#examples-and-results)

## Features

✨ **Core Features:**
- Convert regular images to thermal vision style
- Real-time preview of changes
- Save enhanced images
- Interactive interface

🎨 **Colormap Options:**
- `hot`: Classic thermal camera look (red-yellow heat map)
- `jet`: Rainbow spectrum (blue through red)
- `parula`: MATLAB's default colormap
- `turbo`: Enhanced rainbow colormap
- `winter`: Cool temperature visualization
- `summer`: Warm temperature visualization
- `copper`: Copper-tone gradient

🛠️ **Enhancement Tools:**
- Histogram Equalization
- Contrast Stretching
- Adaptive Equalization
- Temperature scale overlay
- Live histogram display

## How It Works

### Main Interface Overview

1. **Image Loading Area**: Displays your current image
2. **Control Panel**:
   - Image loading button
   - Colormap selection
   - Enhancement options
   - Temperature scale toggle
3. **Histogram Display**: Shows intensity distribution
4. **Output Options**: Save and export features

## Installation

1. **Prerequisites**
   - MATLAB R2019b or newer
   - Image Processing Toolbox (recommended)
   - 4GB RAM minimum
   - Any OS that runs MATLAB

2. **Setup Steps**
   ```matlab
   % Download the repository
   % Extract files to your preferred location
   % In MATLAB, navigate to the project folder:
   cd path/to/thermal-vision-matlab

   % Run the application
   thermal_vision_enhanced
   ```

## Step-by-Step Usage Guide

### 1. Loading an Image
![Load Image](https://i.imgur.com/g7IhQLX.png)
- Click "Load Image" button
- Select any JPG, PNG, or BMP file
- Image automatically converts to grayscale
- Original image appears in the left panel

### 2. Applying Thermal Effect
![Colormap Selection](https://i.imgur.com/hyLFaUG.png)
- Choose a colormap from the dropdown menu
- See immediate results in the preview window
- Adjust temperature scale if needed

### 3. Enhancing the Image
![Enhancement Options](https://i.imgur.com/JIMiakX.png)
- Select enhancement method:
  1. Click desired enhancement button
  2. Adjust parameters if available
  3. See real-time preview
- Toggle between methods to compare results

### 4. Using the Temperature Scale
![Temperature Scale](https://i.imgur.com/KqMWDt0.png)
- Toggle scale visibility
- Helps interpret temperature ranges
- Calibrated to common thermal camera ranges

### 5. Saving Results
- Click "Save Image" button
- Choose save location and format
- Enhanced image saves with all applied effects

## Understanding Enhancement Options

### 1. Histogram Equalization
![Histogram Example](https://i.imgur.com/tHeOXqA.png)

**What it does:**
- Improves contrast by spreading intensity values
- Best for images with poor contrast
- Shows more detail in dark/bright areas

**When to use:**
- Images appear too dark or bright
- Details are hard to see
- Temperature differences are subtle

### 2. Contrast Stretching
![Contrast Example](https://i.imgur.com/crMiBnC.png)

**What it does:**
- Expands intensity range to full scale
- Maintains relative temperature differences
- Creates clearer separation between temperatures

**When to use:**
- Image looks flat or gray
- Need to highlight temperature differences
- Want to preserve relative temperature relationships

### 3. Adaptive Equalization
![Adaptive Example](https://i.imgur.com/WTEspty.png)

**What it does:**
- Enhances local contrast
- Improves detail in all image areas
- Prevents over-enhancement

**When to use:**
- Image has varying brightness regions
- Need to see details in all areas
- Complex scenes with multiple temperature zones

## Tips for Best Results

1. **Image Selection**
   - Use clear, well-focused images
   - Ensure good lighting in original image
   - Higher resolution images work better

2. **Enhancement Selection**
   - Start with basic thermal conversion
   - Try histogram equalization first
   - Use adaptive equalization for complex scenes
   - Experiment with different colormaps

3. **Common Issues and Solutions**
   - Noisy output → Try different enhancement
   - Too bright/dark → Adjust contrast
   - Unclear details → Change colormap
   - Poor contrast → Apply histogram equalization

## Performance Notes

- Processes images up to 4K resolution
- Real-time preview for most operations
- Larger images may take longer to process
- Recommended: Close other applications for better performance
