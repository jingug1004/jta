package anyfive.framework.file.util;

import java.io.File;

import any.core.config.NConfig;
import any.core.exception.NException;
import any.core.exception.NSysException;
import any.util.file.NFileUtil;

import com.fasoo.adk.packager.WorkPackager;

/**
 * DRM Util
 */
public class DRMUtil
{
    private static final String FSDINIT_DIR = "C:/DRM/fsdinit";

    /**
     * DRM 암호화
     *
     * @param sourcePath
     * @param originalName
     * @return
     * @throws NException
     */
    public static String packaging(String sourcePath, String originalName) throws NException
    {
        if (NConfig.getBoolean("/config/drm/enable") != true) return sourcePath;

        WorkPackager workPackager;

        try {
            workPackager = new WorkPackager();
        } catch (Throwable t) {
            throw new NException(t);
        }

        // 암호화 파일 여부
        boolean isPackageFile = workPackager.IsPackageFile(sourcePath);

        if (isPackageFile == true) return sourcePath;

        String targetPath = sourcePath + ".FSD";
        String serverID = "0000000000001973";

        System.out.println("****************** DRM Package file *******************");
        System.out.println("sourcePath : " + sourcePath);
        System.out.println("targetPath : " + targetPath);
        System.out.println("isPackageFile : " + isPackageFile);
        System.out.println("serverID : " + serverID);
        System.out.println("*******************************************************");

        boolean result = workPackager.DoPackaging(FSDINIT_DIR // 환경설정파일(fsdinit폴더) 경로
                , serverID // ServerID
                , sourcePath // 대상파일의 절대경로
                , targetPath // 암호화 후 생성될 파일의 절대경로
                , originalName // 원본파일의 파일명
                , "jusung" // 생성자(등록자) ID
                , "jusung" // 생성자(등록자) 이름
                , NConfig.getString(NConfig.DEFAULT_CONFIG + "/system-title") // 시스템명
                , "" // ACL권한판단
                , "" // 문서의 고유한 값(시스템명_YYYYMMDDhhmmss_파일명)
                , "" // 추가확장용
                , "" // 추가확장용
        );

        if (workPackager.getLastErrorNum() == 11) return sourcePath;

        if (result != true) {
            throw new NSysException("DRM 암호화 오류 : [" + workPackager.getLastErrorNum() + "] " + workPackager.getLastErrorStr());
        }

        NFileUtil.deleteFile(sourcePath);

        new File(targetPath).renameTo(new File(sourcePath));

        return sourcePath;
    }

    /**
     * DRM 복호화
     *
     * @param sourcePath
     * @return
     * @throws NException
     */
    public static String extract(String sourcePath) throws NException
    {
        if (NConfig.getBoolean("/config/drm/enable") != true) return sourcePath;

        WorkPackager workPackager;

        try {
            workPackager = new WorkPackager();
        } catch (Throwable t) {
            throw new NException(t);
        }

        // 암호화 파일 여부
        boolean isPackageFile = workPackager.IsPackageFile(sourcePath);

        if (isPackageFile != true) return sourcePath;

        String targetPath = sourcePath + ".FSD";
        int fileType = workPackager.GetFileType(sourcePath);
        String serverID = null;
        if (fileType == 26) {
            serverID = "0000000000001973";
        } else if (fileType == 103) {
            serverID = "0000000000001636";
        }

        if (serverID == null) return sourcePath;

        System.out.println("****************** DRM Extract file *******************");
        System.out.println("sourcePath : " + sourcePath);
        System.out.println("targetPath : " + targetPath);
        System.out.println("isPackageFile : " + isPackageFile);
        System.out.println("fileType : " + fileType);
        System.out.println("serverID : " + serverID);
        System.out.println("*******************************************************");

        boolean result = workPackager.DoExtract(FSDINIT_DIR, serverID, sourcePath, targetPath);


        if (workPackager.getLastErrorNum() == 11) return sourcePath;

        if (result != true) {
            throw new NSysException("DRM 복호화 오류 : [" + workPackager.getLastErrorNum() + "] " + workPackager.getLastErrorStr());
        }

        NFileUtil.deleteFile(sourcePath);

        new File(targetPath).renameTo(new File(sourcePath));

        return sourcePath;
    }
}
