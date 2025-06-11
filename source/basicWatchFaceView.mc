import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Weather;
using Toybox.Time.Gregorian;

class basicWatchFaceView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }


    function onShow() as Void {}

    function onUpdate(dc as Dc) as Void {
        
        // Obtener hora y fecha actuales
        var clockTime = System.getClockTime();
        
        // Hora
        var timeString = Lang.format(
            "$1$:$2$",
            [ clockTime.hour.format("%02d"), clockTime.min.format("%02d") ]
        );
        var view = View.findDrawableById("TimeLabel") as Text;
        view.setText(timeString);

        // Fecha
        var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        var dateString = Lang.format(
            "$1$ $2$ $3$ $4$",
            [
                today.day_of_week,
                today.day,
                today.month,
                today.year
            ]
        );

        view = View.findDrawableById("DateLabel") as Text;
        view.setText(dateString);

        // Battery
        var batteryLevel = System.getSystemStats().batteryInDays;
        var batteryFormat = batteryLevel.format("%d") + "d";
        view = View.findDrawableById("BatteryLabel") as Text;
        view.setText(batteryFormat);

        // Ahora que view es BatteryLabel, aplicamos color correctamente:
        if (batteryLevel < 10) {
        view.setColor(Graphics.COLOR_RED);
        } else if (batteryLevel < 15) {
        view.setColor(Graphics.COLOR_YELLOW);
        } else {
        view.setColor(Graphics.COLOR_GREEN);
        }




        // Crear el clima
        // var weather = Weather.getCurrentConditions();
        // var condition = weather.condition;
           
        // Texto del clima
        // view = View.findDrawableById("WeatherLabel") as Text;
        // view.setText(condition.toString());
        
        
        


        
        

        // Refrescar layout
        View.onUpdate(dc);
    }

    function onHide() as Void {}

    function onExitSleep() as Void {}

    function onEnterSleep() as Void {}
}
