package anyfive.ipims.patent.systemmgt.configure.update.util;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import any.core.config.NConfig;
import any.core.dataset.NSingleData;

public class SystemUpdateUtil
{
    /**
     * 업데이트 인증키 체크
     *
     * @return
     */
    public static boolean checkUpdateKey(String updateKey)
    {
        return (NConfig.getExists("/security/update-key") && NConfig.getString("/security/update-key").equals(updateKey));
    }

    /**
     * 업데이트 폴더경로 반환
     *
     * @return
     */
    public static String getUpdateSourceRoot()
    {
        String updateSourceRoot = NConfig.getPathName("/config/update/source/root", NConfig.HOME + "/update");

        new File(updateSourceRoot).mkdirs();

        return updateSourceRoot;
    }

    /**
     * 파일정보 반환
     *
     * @param file
     * @return
     */
    public static NSingleData getFileInfo(File file)
    {
        NSingleData result = new NSingleData();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

        result.setString("FILE_NAME", file.getName());
        result.setString("FILE_TYPE", file.getName().substring(file.getName().lastIndexOf(".") + 1).toUpperCase());
        result.setString("FILE_SIZE", Long.toString(file.length()));
        result.setString("FILE_DATETIME", sdf.format(new Date(file.lastModified())));

        return result;
    }
}
