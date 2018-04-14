package com.yizhan.test;
import java.io.File;
/**
 * 解决window删除文件时提示: 源文件名长度大于系统支持的长度
 * @Title:  DeleteFiles.java 
 * @author lj
 * @date 2017年10月25日 上午10:20:10
 */
public class DeleteFiles {

	public static void deleteFiles( File file ){
        
        if( file.isDirectory() ){
            // 如果是一个目录, 先查找这个目录下面的所有文件或目录
            // 再根据情况删除
            File[] files = file.listFiles();
            if( files.length == 0 ){
                //如果是一个空目录,直接删除
                file.delete();
            } else {
                // 如果不是空目录, 则递归
                for( File f : files ){
                    deleteFiles(f);
                    // 递归删除完之后, 再把本目录删除
                    f.getParentFile().delete();
                }
            }
        } else {
            // 如果是一个文件,直接进行删除
            file.delete();
        }
    }
     
    public static void main(String[] args) {
//        File file = new File("E:\\Program Files\\MyEclipse2015CI");
        File file = new File("E:\\Program Files\\aa");
        deleteFiles(file);
    }
	
}
