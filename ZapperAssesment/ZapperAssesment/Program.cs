class Program
{
    static void Main()
    {
        //Ucomment to test Question 2.1
        /*
        Console.Write("Enter user settings: ");
        string settings = Console.ReadLine();

        Console.Write("Enter setting (1-8): ");
        string setting = Console.ReadLine();

        if (int.TryParse(setting, out int value))
        {
            Console.WriteLine(IsFeatureEnabled(settings, value));
        }
        else
        {
            throw new ArgumentOutOfRangeException(nameof(setting), "Setting is invalid.");
        }
        */
       

        //Uncomment to test Question 2.2
        /*
        WriteSettingsToFile("userSettings.txt", "00000010");
        string settings = ReadSettingsFromFile("userSettings.txt");
        Console.WriteLine(settings); 
        */

    }

    static bool IsFeatureEnabled(string settings, int setting)
    {
        if (setting < 1 || setting > settings.Length)
        {
            throw new ArgumentOutOfRangeException(nameof(setting), "User setting is out of range.");
        }

        return settings[setting -1] == '1';
    }

    static void WriteSettingsToFile(string filePath, string settings)
    {
        File.WriteAllText(filePath, settings);
    }

    static string ReadSettingsFromFile(string filePath)
    {
        return File.ReadAllText(filePath).Trim();
    }
}