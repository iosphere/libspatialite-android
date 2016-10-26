### libspatialite-android

Repository containing sources for compiling libspatialite (including its
dependencies GEOS and PROJ.4) statically as an SQLite extension, which
can loaded via SQLite version with extensions loading support enabled.

The file `makeAndroid.sh` builds an Android compatible `libspatialite.so`.
This file must be placed in the respective location of your android-app, e.g;

- `src/main/libs/armeabi-v7a/libspatialite.so`
- `src/main/libs/x86/libspatialite.so`

Then you need an SQlite-version, which is comaptible with Android and allows
for extension loading, e.g. https://github.com/iosphere/sqlite-android

The entrypoint to load libspatialite.so as an SQLite extension is:

`sqlite3_modspatialite_init`.

The file `lispatialite.so` can only be used as an SQLite extension, not as a
standalone version. It does not contain the SQLite symbols.

