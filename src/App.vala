using Gtk;

public class CalcApplication : Gtk.Application {
    public CalcApplication() {
        Object(
            application_id: "eu.dupaw.ttrcalc",
            flags: GLib.ApplicationFlags.FLAGS_NONE
        );
    }

    public override void activate () {
        base.activate();

        var win = this.active_window;
        if (win == null)
            win = new Calc(this);

        var provider = new CssProvider();
        provider.load_from_resource("/eu/dupaw/ttrcalc/ttrcalc.css");
        StyleContext.add_provider_for_display(
            win.get_style_context().get_display(),
            provider,
            STYLE_PROVIDER_PRIORITY_APPLICATION
        );

        win.present();
    }
}

int main (string[] args) {
	return new CalcApplication().run(args);
}
