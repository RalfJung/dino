using Gdk;

using Xmpp;

namespace Dino {
public class AvatarStorage : Xep.PixbufStorage, Object {

    string folder;

    public AvatarStorage(string folder) {
        this.folder = folder;
    }

    public void store(string id, uint8[] data) {
        File file = File.new_for_path(id);
        if (file.query_exists()) file.delete(); //TODO y?
        DataOutputStream fos = new DataOutputStream(file.create(FileCreateFlags.REPLACE_DESTINATION));
        fos.write(data);
    }

    public bool has_image(string id) {
        File file = File.new_for_path(folder + id);
        return file.query_exists();
    }

    public Pixbuf? get_image(string id) {
        try {
            return new Pixbuf.from_file(folder + id);
        } catch (Error e) {
            return null;
        }
    }
}
}