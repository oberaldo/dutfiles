[<- widgets](https://github.com/copycat-killer/lain/wiki/Widgets)

Provides current weather status widgets and X-days forecast popup notifications.

Uses [OpenWeatherMap](http://openweathermap.org/api) API.

By default, it uses [current](http://openweathermap.org/current) for current weather data and [forecast16](http://openweathermap.org/forecast16) for forecasts.

```lua
myweather = lain.widgets.weather()
```

## input table

Variable | Meaning | Type | Default
--- | --- | --- | ---
`timeout` | Refresh timeout seconds for current weather status | int | 900 (15 min)
`timeout_forecast` | Refresh timeout seconds for forecast notification | int | 86400 (24 hrs)
`current_call` | Command to fetch weather status data from the API | string | see `default_current_call`
`forecast_call` | Command to fetch forecast data from the API | string | see `default_forecast_call`
`city_id` | API city code | int | not set
`utc_offset` | UTC time offset | function | see [here](https://github.com/copycat-killer/lain/blob/master/widgets/weather.lua#L44-47)
`units` | Temperature units system | string | "metric" 
`lang` | API data localization | string | "en"
`cnt` | Forecast days interval | int | 5
`date_cmd` | Forecast notification format style | string | "date -u -d @%d +'%%a %%d'"
`icons_path` | Icons path | string | `lain/icons/openweathermap`
`notification_preset` | Preset for notifications | table | empty table
`notification_text_fun` | Function to format forecast notifications | function | see `notification_text_fun`
`weather_na_markup` | Markup to be used when weather textbox is not available | text | " N/A " 
`followmouse` | Notification behaviour | boolean | false
`settings` | User settings | function | empty function

- ``default_current_call`` 

    `"curl -s 'http://api.openweathermap.org/data/2.5/weather?id=%s&units=%s&lang=%s'"`

    You can rewrite it using any fetcher solution you like.

- ``default_forecast_call``
 
    `"curl -s 'http://api.openweathermap.org/data/2.5/forecast/daily?id=%s&units=%s&lang=%s&cnt=%s'"`

    Like above.
    If you want to use [forecast5](http://openweathermap.org/forecast5), use this API call string:
    `http://api.openweathermap.org/data/2.5/forecast?id=%s&units=%s&lang=%s&cnt=%s`

- ``city_id``

    An integer that defines the OpenWeatherMap ID code of your city.
    To obtain it go to [OpenWeatherMap](http://openweathermap.org/) and query for your city in the top search bar. The link will look like this:

        http://openweathermap.org/city/2643743

    your `city_id` is the number at the end.


- ``utc_offset``

    Since OWM provides data in UTC time, we have to adjust the weather icons in order to respect the local timezone day/night cycle.

    If you need to set this function, you can check [here](https://en.wikipedia.org/wiki/List_of_UTC_time_offsets) to know your UTC offset. Note that it must return a number.

- ``units``

    - For temperature in Fahrenheit use `units = "imperial"`
    - For temperature in Celsius use `units = "metric"` (Lain default)
    - For temperature in Kelvin use `units = "standard"` (OpenWeatherMap default)

- ``lang``

    See *Multilingual Support* section [here](http://openweathermap.org/current).

- ``cnt``

    Determines how many days to show in the forecast notification. Up to 16 if you use [forecast16](http://openweathermap.org/forecast16)  (default), and up to 5 if you use [forecast5](http://openweathermap.org/forecast5).

- ``date_cmd``

    OpenWeatherMap time is in UNIX format, so this variable uses `date` to determine how each line in the forecast notification is formatted. Default looks like this:

        day #daynumber: forecast, temp_min - temp_max

    see `man date` for your customizations.

- ``icons_path``

    You can set your own icons path if you don't wish to use `lain/icons/openweathermap`. Just be sure that your icons are PNGs and named exactly like [OpenWeatherMap ones](http://openweathermap.org/weather-conditions).

- ``notification_preset``

   Notifications preset table. See [here](http://awesome.naquadah.org/doc/api/modules/naughty.html#notify) for the details.

- ``notification_text_fun``
   ```lua
   function (wn)
       local day = string.gsub(read_pipe(string.format(date_cmd, wn["dt"])), "\n", "")
       local tmin = math.floor(wn["temp"]["min"])
       local tmax = math.floor(wn["temp"]["max"])
       local desc = wn["weather"][1]["description"]

       return string.format("<b>%s</b>: %s, %d - %d ", day, desc, tmin, tmax)
   end
   ```
   See [here](https://github.com/copycat-killer/lain/issues/186#issuecomment-203400918) for a complete customization example.

- ``followmouse``

   In multiple screen setups, the default behaviour is to show a visual notification pop-up window on the first screen when the widget is hovered with the mouse. By setting followmouse to true it will be shown on the same screen containing the widget.

- ``settings``

    In your `settings` function, you can use `widget` variable to refer to the textbox, and the dictionary `weather_now` to refer to data retrieved by `current_call`. The dictionary is built with [dkjson library](http://dkolf.de/src/dkjson-lua.fsl/home), and its structure is defined [here](http://openweathermap.org/weather-data).
    For instance, you can retrieve current weather status and temperature [in this way](https://github.com/copycat-killer/awesome-copycats/blob/master/rc.lua.multicolor#L139-140).

In multiple screen setups, the default behaviour is to show a visual notification pop-up window on the first screen when the widget is hovered with the mouse. By setting `followmouse` to `true` it will be shown on the same screen containing the widget.

## Usage
The module creates an imagebox icon and a textbox widget. Add them to you wibox like this:

    right_layout:add(myweather)
    right_layout:add(myweather.icon)

### attach
You can attach the forecast notification to any widget like this:

    myweather.attach(obj)

Hovering over ``obj`` will display the notification.

### update

    myweather.update()

Force fetching of current weather status data. Useful when combined with other widgets workflow (for instance, it can be called from net widget when the internet connection is restored).

### forecast_update

    myweather.forecast_update()

Like above, but for the forecast notification.

### popup shortcut

You can also create a keybinding for the weather popup like this:

    awful.key( { "Mod1" }, "w", function () myweather.show(5) end )

where ``show`` argument is an integer defining timeout seconds.
