package todevs.com.collegemate;

import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.IBinder;
import android.preference.PreferenceManager;
import android.util.Log;

import com.android.volley.NetworkResponse;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

/**
 * Created by sai kiran on 6/28/2016.
 */
public class TokenRefreshService extends Service
{
    private static Timer timer = new Timer();
    private Context ctx;
    private static final String TAG = "TokenRefreshActivity";
    private SharedPreferences mSharedPreferences;

    private HashMap<String,String> mHeaders;
    public IBinder onBind(Intent arg0)
    {
        return null;
    }

    public void onCreate()
    {
        super.onCreate();
        ctx = this;
        mSharedPreferences = PreferenceManager.getDefaultSharedPreferences(this);
        startService();
    }

    private void startService()
    {
        timer.scheduleAtFixedRate(new mainTask(), 0, 175 * 60 * 1000);
    }

    private class mainTask extends TimerTask
    {
        public void run()
        {
            RequestQueue queue = Volley.newRequestQueue(ctx);
            String url ="http://139.59.4.205/api/v1_0/refresh";


// Request a string response from the provided URL.
// could be any class that implements Map
            mHeaders = new HashMap<String, String>();
            mHeaders.put("Authorization", mSharedPreferences.getString("token",null));

            JsonObjectRequest jsonRequest = new JsonObjectRequest(Request.Method.GET, url,
                    new Response.Listener<JSONObject>() {
                        @Override
                        public void onResponse(JSONObject response) {
                            Log.d(TAG,"Response is: "+ response);
                        }
                    }, new Response.ErrorListener() {
                @Override
                public void onErrorResponse(VolleyError error) {
                    Log.e(TAG,"That didn't work!");
                }
            }){
                public Map<String, String> getHeaders() {
                    return mHeaders;
                }
                @Override
                protected Response parseNetworkResponse(NetworkResponse response) {
                    Map<String, String> responseHeaders = response.headers;

                    SharedPreferences.Editor editor = mSharedPreferences.edit();
                    editor.putString("token", responseHeaders.get("Authorization"));
                    editor.commit();
                    Log.d(TAG,"Response Header is: "+ responseHeaders.get("Authorization"));
                    Log.d(TAG,"Shared Preference: "+ mSharedPreferences.getString("token",null));

                    return super.parseNetworkResponse(response);
                }
            };
// Add the request to the RequestQueue.
            queue.add(jsonRequest);
        }

    }

    public void onDestroy()
    {
        super.onDestroy();

    }
}
