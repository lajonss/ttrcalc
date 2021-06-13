using Gdk;
using Gee;
using Gtk;


[GtkTemplate (ui="/eu/dupaw/ttrcalc/main-window.ui")]
public class Calc : ApplicationWindow {
    [GtkChild] unowned TextView output;
    [GtkChild] unowned TextView history;

    TextBuffer output_buffer;
    TextBuffer history_buffer;

    HashMap<int, int> points;
    Deque<int> current;
    int sum;

    public Calc (Gtk.Application app) {
        Object (
            application: app
        );
        points = new HashMap<int, int>();
        points[1] = 1;
        points[2] = 2;
        points[3] = 4;
        points[4] = 7;
        points[5] = 10;
        points[6] = 15;
        points[7] = 18;
        points[8] = 21;
        points[9] = 27;
        points[10] = 40;

        current = new ArrayQueue<int>();
        output_buffer = output.buffer;
        history_buffer = history.buffer;
        update_output();
        output_buffer.set_modified(true);

        var key_controller = new EventControllerKey();
        key_controller.key_pressed.connect(on_key_pressed);
        ((Widget)this).add_controller(key_controller);
    }

	[GtkCallback]
    void on_button_click (Button source) {
        add (int.parse (source.name));
    }

    [GtkCallback]
    void on_button_back () {
        remove_last_amount ();
    }

    [GtkCallback]
    void on_button_clear () {
        clear_current ();
    }

    bool on_key_pressed (EventControllerKey _key_controller, uint keyval, uint keycode, ModifierType state) {
        var key_name = keyval_name(keyval);
        switch (key_name) {
            case "BackSpace":
                remove_last_amount();
                return true;
            case "Delete":
            case "space":
            case "KP_Enter":
            case "Return":
                clear_current();
                return true;
            case "q":
                if ((state & ModifierType.CONTROL_MASK) != 0)
                    destroy();
                    return true;
            default:
                if (key_name.length == 1)
                    return check_for_number(key_name[0]);
                if (key_name.length == 4)
                    return check_for_number(key_name[3]);
                return false;
        }
    }

    bool check_for_number (char potential_number) {
        int number = potential_number - 48;
        if (number < 0 || number > 9)
            return false;

        if (number == 0)
            add(10);
        else
            add(number);
        return true;
    }

    void add (int amount) {
        current.offer_tail (points[amount]);
        update_output ();
    }

    void remove_last_amount () {
        current.poll_tail ();
        update_output ();
    }

    void clear_current () {
        update_history ();
        current.clear ();
        update_output ();
    }

    void update_output () {
        sum = 0;
        if (current.size == 0) {
            output_buffer.text = "0";
            return;
        }

        var builder = new StringBuilder(" = ");
        var first = true;
        foreach (var amount in current) {
            sum += amount;
            if (first)
                first = false;
            else
                builder.append (" + ");
            builder.append (amount.to_string ());
        }

        builder.prepend (sum.to_string ());
        output_buffer.text = builder.str;
    }

    void update_history () {
        var existing_text = history_buffer.text;
        if (existing_text == "")
            history_buffer.text = sum.to_string();
        else
            history_buffer.text = existing_text + ", " + sum.to_string ();
    }
}
