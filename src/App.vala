public class CalcApplication : Gtk.Application {
    public CalcApplication() {
        Object (
            application_id: "eu.dupaw.ttrcalc",
            flags: GLib.ApplicationFlags.FLAGS_NONE
        );
    }

    public override void activate () {
        base.activate ();

        var win = this.active_window;
        if (win == null)
            win = new Calc(this);
        win.present ();
    }
}

int main (string[] args) {
	return new CalcApplication ().run (args);
}
