Add-Type -AssemblyName "PresentationCore", "PresentationFramework", "WindowsBase"

[xml]$xamlMarkup = @'
<Window 
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"        
        Name="Window" Title="Windows 10 Setup Script" MinHeight="760" MinWidth="1118" Height="760" Width="1118" 
        FontFamily="Calibri" FontSize="14" TextOptions.TextFormattingMode="Display" WindowStartupLocation="CenterScreen" 
        SnapsToDevicePixels="True" WindowStyle="None" ResizeMode="CanResizeWithGrip" AllowsTransparency="True" 
        ShowInTaskbar="True" Background="{DynamicResource {x:Static SystemColors.WindowBrushKey}}"
        Foreground="{DynamicResource {x:Static SystemColors.WindowTextBrushKey}}">

    <Window.Resources>

        <!--#region Brushes -->
        <SolidColorBrush x:Key="RadioButton.Static.Background" Color="#FFFFFFFF"/>
        <SolidColorBrush x:Key="RadioButton.Static.Border" Color="#FF333333"/>
        <SolidColorBrush x:Key="RadioButton.Static.Glyph" Color="#FF333333"/>

        <SolidColorBrush x:Key="RadioButton.MouseOver.Background" Color="#FFFFFFFF"/>
        <SolidColorBrush x:Key="RadioButton.MouseOver.Border" Color="#FF000000"/>
        <SolidColorBrush x:Key="RadioButton.MouseOver.Glyph" Color="#FF000000"/>

        <SolidColorBrush x:Key="RadioButton.MouseOver.On.Background" Color="#FF4C91C8"/>
        <SolidColorBrush x:Key="RadioButton.MouseOver.On.Border" Color="#FF4C91C8"/>
        <SolidColorBrush x:Key="RadioButton.MouseOver.On.Glyph" Color="#FFFFFFFF"/>

        <SolidColorBrush x:Key="RadioButton.Disabled.Background" Color="#FFFFFFFF"/>
        <SolidColorBrush x:Key="RadioButton.Disabled.Border" Color="#FF999999"/>
        <SolidColorBrush x:Key="RadioButton.Disabled.Glyph" Color="#FF999999"/>

        <SolidColorBrush x:Key="RadioButton.Disabled.On.Background" Color="#FFCCCCCC"/>
        <SolidColorBrush x:Key="RadioButton.Disabled.On.Border" Color="#FFCCCCCC"/>
        <SolidColorBrush x:Key="RadioButton.Disabled.On.Glyph" Color="#FFA3A3A3"/>

        <SolidColorBrush x:Key="RadioButton.Pressed.Background" Color="#FF999999"/>
        <SolidColorBrush x:Key="RadioButton.Pressed.Border" Color="#FF999999"/>
        <SolidColorBrush x:Key="RadioButton.Pressed.Glyph" Color="#FFFFFFFF"/>

        <SolidColorBrush x:Key="RadioButton.Checked.Background" Color="#FF0063B1"/>
        <SolidColorBrush x:Key="RadioButton.Checked.Border" Color="#FF0063B1"/>
        <SolidColorBrush x:Key="RadioButton.Checked.Glyph" Color="#FFFFFFFF"/>
        <!--#endregion-->
        
        <Style x:Key="PanelCategoryButtons" TargetType="StackPanel">
            <Setter Property="Orientation" Value="Horizontal"/>
            <Setter Property="VerticalAlignment" Value="Bottom"/>            
            <Style.Triggers>
                <Trigger  Property="IsMouseOver" Value="True">
                    <Setter Property="Background" Value="#DA1F2E"/>                    
                </Trigger>
                <Trigger  Property="IsMouseOver" Value="False">
                    <Setter Property="Background" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>                    
                </Trigger>
                <EventTrigger RoutedEvent="MouseDown">
                    <EventTrigger.Actions>
                        <BeginStoryboard>
                            <Storyboard>
                                <ThicknessAnimation  Storyboard.TargetProperty="Margin" Duration="0:0:1" From="0 0 0 0" To="0 0 0 -5" SpeedRatio="5" AutoReverse="True" />
                            </Storyboard>
                        </BeginStoryboard>
                    </EventTrigger.Actions>
                </EventTrigger>
            </Style.Triggers>            
        </Style>

        <Style x:Key="PanelFooterButtons" TargetType="StackPanel">
            <Setter Property="Orientation" Value="Horizontal"/>
            <Setter Property="VerticalAlignment" Value="Center"/>
            <Setter Property="HorizontalAlignment" Value="Center"/>
            <Style.Triggers>                
                <EventTrigger RoutedEvent="MouseDown">
                    <EventTrigger.Actions>
                        <BeginStoryboard>
                            <Storyboard>
                                <ThicknessAnimation  Storyboard.TargetProperty="Margin" Duration="0:0:1" From="0 0 0 0" To="0 0 0 -5" SpeedRatio="5" AutoReverse="True" />
                            </Storyboard>
                        </BeginStoryboard>
                    </EventTrigger.Actions>
                </EventTrigger>
            </Style.Triggers>
        </Style>

        <Style x:Key="TextBlockCategory Buttons" TargetType="TextBlock">
            <Setter Property="Foreground" Value="#FFFFFF"/>
            <Setter Property="VerticalAlignment" Value="Center"/>
            <Setter Property="HorizontalAlignment" Value="Center"/>
            <Setter Property="Margin" Value="10"/>            
        </Style>

        <Style x:Key="ViewboxFooter" TargetType="{x:Type Viewbox}">
            <Setter Property="Width" Value="22"/>
            <Setter Property="Height" Value="22"/>
            <Setter Property="VerticalAlignment" Value="Center"/>
            <Setter Property="HorizontalAlignment" Value="Center"/>
            <Setter Property="Margin" Value="5 0 5 0"/>
        </Style>

    </Window.Resources>

    <Border Name="BorderWindow" BorderThickness="1" BorderBrush="#3F51B5">
        <Grid>
            <Grid.RowDefinitions>
                <RowDefinition Height="80"/>
                <RowDefinition Height="50"/>
                <RowDefinition Height="*"/>
                <RowDefinition Height="30"/>
            </Grid.RowDefinitions>
            
            <!--#region Title Panel-->
            <Grid Grid.Row="0" Background="{Binding ElementName=BorderWindow, Path=BorderBrush}">
                <Grid.Effect>
                    <DropShadowEffect Direction="350" BlurRadius="7" Opacity="0.7"/>
                </Grid.Effect>
                <!--#region Logo Panel-->
                <StackPanel Orientation="Horizontal" VerticalAlignment="Top" HorizontalAlignment="Center" Height="30">
                    <Viewbox Width="24" Height="24" VerticalAlignment="Center" Margin="10 10 10 0">
                        <Canvas Width="24" Height="24">
                            <Path Data="M3,12V6.75L9,5.43V11.91L3,12M20,3V11.75L10,11.9V5.21L20,3M3,13L9,13.09V19.9L3,18.75V13M20,13.25V22L10,20.09V13.1L20,13.25Z" Fill="#FFFFFF" />
                        </Canvas>
                    </Viewbox>
                    <TextBlock Text="WINDOWS 10 SETUP SCRIPT" FontSize="16" Foreground="#FFFFFF" 
                               Margin="0 10 10 0" VerticalAlignment="Center"/>
                </StackPanel>
                <!--#endregion Logo Panel-->
                
                <!--#region Close Button-->
                <StackPanel Name="ButtonClose" Grid.Row="0" HorizontalAlignment="Right" VerticalAlignment="Top">
                    <StackPanel.Style>
                        <Style TargetType="StackPanel">
                            <Style.Triggers>
                                <Trigger Property="IsMouseOver" Value="True">
                                    <Setter Property="Background" Value="#DA1F2E"/>                                    
                                </Trigger>
                                <Trigger Property="IsMouseOver" Value="False">
                                    <Setter Property="Background" Value="#3F51B5"/>
                                </Trigger>
                            </Style.Triggers>
                        </Style>
                    </StackPanel.Style>
                    <Viewbox Width="24" Height="24" Margin="3">
                        <Canvas Width="24" Height="24">
                            <Path Data="M19,6.41L17.59,5L12,10.59L6.41,5L5,6.41L10.59,12L5,17.59L6.41,19L12,13.41L17.59,19L19,17.59L13.41,12L19,6.41Z"
                                  Fill="#FFFFFF">
                                <Path.Style>
                                    <Style TargetType="Path">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=PanelCloseButton, Path=IsMouseOver}" Value="True">
                                                <Setter Property="Opacity" Value="1"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=PanelCloseButton, Path=IsMouseOver}" Value="False">
                                                <Setter Property="Opacity" Value="0.5"/>
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </Path.Style>
                            </Path>
                        </Canvas>
                    </Viewbox>
                </StackPanel>
                <!--#endregion Close Button-->

                <!--#region Category Buttons Panel-->                
                <StackPanel Height="60" Orientation="Horizontal" VerticalAlignment="Bottom" Margin="0 30 0 0">
                    
                    <!--#region Privacy & Telemetry Button-->
                    <StackPanel Name="ButtonGroup_Privacy" Style="{StaticResource PanelCategoryButtons}">
                        <TextBlock Text="Privacy &amp; Telemetry" Style="{StaticResource TextBlockCategory Buttons}"/>
                    </StackPanel>
                    <!--#endregion Privacy & Telemetry Button-->

                    <!--#region UI & Personalization Button-->
                    <StackPanel Name="ButtonGroup_Ui" Style="{StaticResource PanelCategoryButtons}">
                        <TextBlock Text="UI &amp; Personalization" Style="{StaticResource TextBlockCategory Buttons}"/>
                    </StackPanel>
                    <!--#endregion UI & Personalization Button-->

                    <!--#region OneDrive Button-->
                    <StackPanel Name="ButtonGroup_OneDrive" Style="{StaticResource PanelCategoryButtons}">
                        <TextBlock Text="OneDrive" Style="{StaticResource TextBlockCategory Buttons}"/>
                    </StackPanel>
                    <!--#endregion OneDrive Button-->

                    <!--#region Start Menu Button-->
                    <StackPanel Name="ButtonGroup_StartMenu" Style="{StaticResource PanelCategoryButtons}">
                        <TextBlock Text="Start Menu" Style="{StaticResource TextBlockCategory Buttons}"/>
                    </StackPanel>
                    <!--#endregion Start Menu Button-->

                    <!--#region Microsoft Edge Button-->
                    <StackPanel Name="ButtonGroup_Edge" Style="{StaticResource PanelCategoryButtons}">
                        <TextBlock Text="Microsoft Edge" Style="{StaticResource TextBlockCategory Buttons}"/>
                    </StackPanel>
                    <!--#endregion Microsoft Edge Button-->

                    <!--#region UWP Apps Button-->
                    <StackPanel Name="ButtonGroup_Uwp" Style="{StaticResource PanelCategoryButtons}">
                        <TextBlock Text="UWP Apps" Style="{StaticResource TextBlockCategory Buttons}"/>
                    </StackPanel>
                    <!--#endregion UWP Apps Button-->

                    <!--#region Windows Game Recording Button-->
                    <StackPanel Name="ButtonGroup_GameRecording" Style="{StaticResource PanelCategoryButtons}">
                        <TextBlock Text="Windows Game Recording" Style="{StaticResource TextBlockCategory Buttons}"/>
                    </StackPanel>
                    <!--#endregion Windows Game Recording Button-->

                    <!--#region Scheduled Tasks Button-->
                    <StackPanel Name="ButtonGroup_Tasks" Style="{StaticResource PanelCategoryButtons}">
                        <TextBlock Text="Scheduled Tasks" Style="{StaticResource TextBlockCategory Buttons}"/>
                    </StackPanel>
                    <!--#endregion Scheduled Tasks Button-->

                    <!--#region Microsoft Defender Button-->
                    <StackPanel Name="ButtonGroup_Defender" Style="{StaticResource PanelCategoryButtons}">
                        <TextBlock Text="Microsoft Defender" Style="{StaticResource TextBlockCategory Buttons}"/>
                    </StackPanel>
                    <!--#endregion Microsoft Defender Button-->

                    <!--#region Context Menu Button-->
                    <StackPanel Name="ButtonGroup_ContextMenu" Style="{StaticResource PanelCategoryButtons}">
                        <TextBlock Text="Context Menu" Style="{StaticResource TextBlockCategory Buttons}"/>
                    </StackPanel>
                    <!--#endregion Context Menu Button-->
                    
                </StackPanel>                
                <!--#endregion Category Buttons Panel-->

            </Grid>            
            <!--#endregion Title Panel-->
            
            <!--#region Footer Panel-->

            <!--#region Follow on GitHub Button-->
            <StackPanel Grid.Row="3" Orientation="Horizontal" Background="{Binding ElementName=BorderWindow, Path=BorderBrush}">
                <StackPanel.Style>
                    <Style TargetType="StackPanel">
                        <Style.Triggers>                            
                            <EventTrigger RoutedEvent="MouseDown">
                                <EventTrigger.Actions>
                                    <BeginStoryboard>
                                        <Storyboard>
                                            <ThicknessAnimation  Storyboard.TargetProperty="Margin" Duration="0:0:1" From="0 0 0 0" To="0 0 0 -5" SpeedRatio="5" AutoReverse="True" />
                                        </Storyboard>
                                    </BeginStoryboard>
                                </EventTrigger.Actions>
                            </EventTrigger>
                        </Style.Triggers>
                    </Style>
                </StackPanel.Style>
                <Viewbox Style="{StaticResource ViewboxFooter}" >
                    <Canvas Width="24" Height="24">
                        <Path Data="M12,2A10,10 0 0,0 2,12C2,16.42 4.87,20.17 8.84,21.5C9.34,21.58 9.5,21.27 9.5,21C9.5,20.77 9.5,20.14 9.5,19.31C6.73,19.91 6.14,17.97 6.14,17.97C5.68,16.81 5.03,16.5 5.03,16.5C4.12,15.88 5.1,15.9 5.1,15.9C6.1,15.97 6.63,16.93 6.63,16.93C7.5,18.45 8.97,18 9.54,17.76C9.63,17.11 9.89,16.67 10.17,16.42C7.95,16.17 5.62,15.31 5.62,11.5C5.62,10.39 6,9.5 6.65,8.79C6.55,8.54 6.2,7.5 6.75,6.15C6.75,6.15 7.59,5.88 9.5,7.17C10.29,6.95 11.15,6.84 12,6.84C12.85,6.84 13.71,6.95 14.5,7.17C16.41,5.88 17.25,6.15 17.25,6.15C17.8,7.5 17.45,8.54 17.35,8.79C18,9.5 18.38,10.39 18.38,11.5C18.38,15.32 16.04,16.16 13.81,16.41C14.17,16.72 14.5,17.33 14.5,18.26C14.5,19.6 14.5,20.68 14.5,21C14.5,21.27 14.66,21.59 15.17,21.5C19.14,20.16 22,16.42 22,12A10,10 0 0,0 12,2Z" Fill="#FFFFFF" />
                    </Canvas>
                </Viewbox>
                <TextBlock Name="TextBlock_GitHub" Foreground="#FFFFFF" VerticalAlignment="Center" Padding="5 3 5 3">
                    <TextBlock.Style>
                        <Style TargetType="{x:Type TextBlock}">
                            <Style.Triggers>
                                <Trigger Property="IsMouseOver" Value="True">
                                    <Setter Property="Text" Value="https://github.com/farag2/Windows-10-Setup-Script"/>
                                    <Setter Property="TextDecorations" Value="Underline"/>
                                    <Setter Property="Cursor" Value="Hand"/>
                                </Trigger>
                                <Trigger Property="IsMouseOver" Value="False">
                                    <Setter Property="Text" Value="Follow on GitHub"/>
                                </Trigger>
                            </Style.Triggers>
                        </Style>
                    </TextBlock.Style>
                </TextBlock>
            </StackPanel>
            <!--#endregion Follow on GitHub Button-->

            <!--#region Change Language Button-->
            <StackPanel Name="Button_ChangeLanguage" Grid.Row="3" Style="{StaticResource PanelFooterButtons}" HorizontalAlignment="Right">
                <TextBlock Foreground="#FFFFFF" VerticalAlignment="Center" 
                           Padding="10 3 14 3">
                    <TextBlock.Style>
                        <Style TargetType="{x:Type TextBlock}">
                            <Style.Triggers>
                                <Trigger Property="IsMouseOver" Value="True">
                                    <Setter Property="Text" Value="RU"/>                                    
                                    <Setter Property="Cursor" Value="Hand"/>
                                </Trigger>
                                <Trigger Property="IsMouseOver" Value="False">
                                    <Setter Property="Text" Value="EN"/>
                                </Trigger>
                            </Style.Triggers>
                        </Style>
                    </TextBlock.Style>
                </TextBlock>

            </StackPanel>
            <!--#endregion Change Language Button-->
            
            <!--#endregion Footer Panel-->

        </Grid>
    </Border>
</Window>
'@

$xamlGui = [System.Windows.Markup.XamlReader]::Load((New-Object System.Xml.XmlNodeReader $xamlMarkup))
$xamlMarkup.SelectNodes('//*[@Name]') | ForEach-Object {
    New-Variable -Name $_.Name -Value $xamlGui.FindName($_.Name)
        
}

#region Script Functions
function Hide-Console {
    <#
    .SYNOPSIS
    Hide Powershell console before show WPF GUI.    
    #>

    [CmdletBinding()]
    param ()

    Add-Type -Name Window -Namespace Console -MemberDefinition '
    [DllImport("Kernel32.dll")]
    public static extern IntPtr GetConsoleWindow();

    [DllImport("user32.dll")]
    public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
    [Console.Window]::ShowWindow([Console.Window]::GetConsoleWindow(), 0)
}

function Join-ToGithub {
    <#
    .SYNOPSIS
    Open "https://github.com/farag2/Windows-10-Setup-Script" in default browser.    
    #>
    [CmdletBinding()]
    param ()

    Start-Process -FilePath "explorer.exe" -ArgumentList "https://github.com/farag2/Windows-10-Setup-Script"    
}
#endregion

#region Controls Events
$Window.Add_MouseLeftButtonDown({
    $Window.DragMove()
})

$ButtonClose.Add_MouseLeftButtonDown({
    $Window.Close()
})

$TextBlock_GitHub.Add_MouseLeftButtonDown({
    Join-ToGithub
})




#endregion

Hide-Console
$Window.ShowDialog() | Out-Null