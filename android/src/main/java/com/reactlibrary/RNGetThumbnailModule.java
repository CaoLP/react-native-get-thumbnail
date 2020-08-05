
package com.reactlibrary;

import android.graphics.Bitmap;
import android.media.MediaMetadataRetriever;
import android.net.Uri;
import android.util.Log;
import android.webkit.URLUtil;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.NoSuchKeyException;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;

import java.io.File;
import java.io.FileOutputStream;
import java.util.HashMap;

public class RNGetThumbnailModule extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;
    private static final String TAG = "RNGetThumbnail";
    private static final String ERROR_TAG = "E_GET_THUMBNAIL";
    private static String ERR_COULD_NOT_GET_THUMBNAIL = "ERR_COULD_NOT_GET_THUMBNAIL";

    private static final String KEY_QUALITY = "quality";
    private static final String KEY_TIME = "time";
    private static final String KEY_HEADERS = "headers";

    public RNGetThumbnailModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return "RNGetThumbnail";
    }

    @ReactMethod
    public void getThumbnail(
            String source,
            ReadableMap videoOptions,
            Promise promise) {
        try {
            Log.println(Log.INFO, TAG, videoOptions.toString());
            MediaMetadataRetriever metadataRetriever = new MediaMetadataRetriever();
            Log.println(Log.INFO, TAG, source);
            long time = videoOptions.getInt("time") * 1000;
            WritableMap map = Arguments.createMap();
            Log.println(Log.INFO, TAG, time + "");
            if (URLUtil.isFileUrl(source)) {
                metadataRetriever.setDataSource(Uri.decode(source).replace("file://", ""));
            } else {
                HashMap<String, String> headerMap = new HashMap<>();
                HashMap requestMap;
                try {
                    requestMap = videoOptions.getMap(KEY_HEADERS).toHashMap();
                    for (Object key : requestMap.keySet()) {
                        headerMap.put(key.toString(), (String) requestMap.get(key));
                    }
                } catch (Exception ex) {
                    Log.println(Log.INFO, TAG, ex.getMessage());
                }
                Log.println(Log.INFO, TAG, headerMap.toString());
                metadataRetriever.setDataSource(source, headerMap);
            }
            Bitmap bitmap = metadataRetriever.getFrameAtTime(time, MediaMetadataRetriever.OPTION_CLOSEST_SYNC);
            File bitmapFile = File.createTempFile("VideoThumbnails", ".jpg", this.reactContext.getCacheDir());
            FileOutputStream outputStream = new FileOutputStream(bitmapFile);
            int quality = 1;
            try {
                quality = (int) (videoOptions.getDouble(KEY_QUALITY) * 100);
            } catch (NoSuchKeyException nokey) {

            }
            bitmap.compress(Bitmap.CompressFormat.PNG, quality, outputStream);
            outputStream.flush();
            outputStream.close();
            String imagePath = bitmapFile.getAbsolutePath();
            map.putString("uri", Uri.fromFile(new File(imagePath)).toString());
            map.putInt("width", bitmap.getWidth());
            map.putInt("height", bitmap.getHeight());
            promise.resolve(map);
        } catch (Exception e) {
            Log.println(Log.INFO, TAG, e.toString());
            promise.reject(ERR_COULD_NOT_GET_THUMBNAIL, e);
        }
    }
}