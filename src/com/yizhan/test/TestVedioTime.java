package com.yizhan.test;

import it.sauronsoftware.jave.Encoder;  
import it.sauronsoftware.jave.FFMPEGLocator;  
import it.sauronsoftware.jave.MultimediaInfo;  
  
  
import java.io.File;  
  
  
public class TestVedioTime {  
  
  
    public static void main(String[] args) {  
        // *.mp4，*.flv，*..3gp格式均可,其他自行测试  
        // <vedio_path>是你的视频文件路径  
        File source = new File("<vedio_path>\\Avengers2.flv");  
        FFMPEGLocator locator = new FFMPEGLocator() {  
            @Override  
            protected String getFFMPEGExecutablePath() {  
                // <ffmpeg_path>是你的ffmpeg.exe路径  
                return "<ffmpeg_path>\\ffmpeg.exe";  
            }  
        };  
        Encoder encoder = new Encoder(locator);  
        try {  
            MultimediaInfo m = encoder.getInfo(source);  
            long ls = m.getDuration();  
            // 输出毫秒数  
            System.out.println(ls);  
            // 输出0时0分0秒0毫秒的格式  
            System.out.println("此视频时长为:" + ls / (60 * 60 * 1000) + "时" + (ls % (60 * 60 * 1000)) / 60000 + "分"  
                    + ((ls % (60 * 60 * 1000)) % 60000) / 1000 + "秒" + (((ls % (60 * 60 * 1000)) % 60000) % 1000)  
                    + "毫秒！");  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
    }  
}  