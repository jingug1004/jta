package anyfive.framework.file.util;

import any.core.dataset.NJobTypeEnum;
import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.util.file.NFileConfig;
import any.util.file.NFileUtil;
import anyfive.framework.ajax.AjaxRequest;

public class FileUtil
{
    private static final String ATTACH_FILE_LIST = "$ATTACH_FILE_LIST";

    public static void initAttachFileList(NServiceResource nsr)
    {
        nsr.userData.set(ATTACH_FILE_LIST, new NMultiData());
    }

    public static void setFileData(NServiceResource nsr, NMultiData fileList)
    {
        NMultiData attachFileList = (NMultiData)nsr.userData.get(ATTACH_FILE_LIST);

        for (int i = 0; i < fileList.getRowSize(); i++) {
            attachFileList.addSingleData(fileList.getSingleData(i));
        }
    }

    public static void setFileDataForDelete(NServiceResource nsr, NMultiData fileList)
    {
        NMultiData attachFileList = (NMultiData)nsr.userData.get(ATTACH_FILE_LIST);

        for (int i = 0; i < fileList.getRowSize(); i++) {
            fileList.setJobType(i, NJobTypeEnum.DELETE);
            attachFileList.addSingleData(fileList.getSingleData(i));
        }
    }

    public static void deleteLocalFileList(NServiceResource nsr) throws NException
    {
        deleteLocalFileList((NMultiData)nsr.userData.get(ATTACH_FILE_LIST), true);
    }

    public static void deleteLocalFileList(AjaxRequest xReq) throws NException
    {
        NMultiData attachFileList = new NMultiData();
        NSingleData allData = xReq.getData();
        NMultiData reqData = null;

        for (int i = 0; i < allData.getKeySize(); i++) {
            reqData = xReq.getMultiData(allData.getKey(i));

            if (reqData.getKeyIndex("[==FILE_DATA==]") != 0) continue;

            for (int j = 0; j < reqData.getRowSize(); j++) {
                if (reqData.getJobType(j) != NJobTypeEnum.CREATE) continue;
                reqData.setJobType(j, NJobTypeEnum.DELETE);
                attachFileList.addSingleData(reqData.getSingleData(j));
            }
        }

        deleteLocalFileList(attachFileList, false);
    }

    private static void deleteLocalFileList(NMultiData fileList, boolean checkConfig) throws NException
    {
        for (int i = 0; i < fileList.getRowSize(); i++) {
            if (fileList.getJobType(i) != NJobTypeEnum.DELETE) continue;
            deleteLocalFile(fileList, checkConfig, i);
        }
    }

    private static void deleteLocalFile(NMultiData fileList, boolean checkConfig, int row) throws NException
    {
        String policy = fileList.getString(row, "FILE_POLICY");
        String repository = fileList.getString(row, "FILE_REPOSITORY");
        String filePath = fileList.getString(row, "FILE_PATH");
        String fileName = fileList.getString(row, "FILE_NAME");

        if (checkConfig && Boolean.valueOf(NFileConfig.getConfig(policy, "delete-file")).booleanValue() != true) return;

        for (int i = 0; i < fileList.getRowSize(); i++) {
            if (fileList.getJobType(i) != NJobTypeEnum.CREATE) continue;
            if (fileList.getString(i, "FILE_POLICY").equals(policy) != true) continue;
            if (fileList.getString(i, "FILE_REPOSITORY").equals(repository) != true) continue;
            if (fileList.getString(i, "FILE_PATH").equals(filePath) != true) continue;
            if (fileList.getString(i, "FILE_NAME").equals(fileName) != true) continue;
            return;
        }

        NFileUtil.deleteFile(NFileConfig.getRepositoryPathByName(repository) + NFileConfig.getConfig(policy, "sub-path") + filePath + "/" + fileName);
    }

    public static String getSaveFilePath(NSingleData fileInfo) throws NException
    {
        return getSaveFilePath(fileInfo, null);
    }

    public static String getSaveFilePath(NSingleData fileInfo, String fileNamePrefix) throws NException
    {
        String policy = fileInfo.getString("FILE_POLICY");
        String repositoryPath = NFileConfig.getRepositoryPathByName(fileInfo.getString("FILE_REPOSITORY"));
        String subPath = NFileConfig.getConfig(policy, "sub-path");
        String filePath = fileInfo.getString("FILE_PATH");
        String fileName = (fileNamePrefix == null ? "" : fileNamePrefix) + fileInfo.getString("FILE_NAME");

        return NFileUtil.getCanonicalPath(repositoryPath + subPath + filePath + "/" + fileName);
    }
}
