package model;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.Part;

// 画像アップロード処理を行うロジッククラス
public class ImageUploadLogic {

    // ファイルをサーバーに保存&ファイル名を返す
    public String uploadImage(Part filePart, ServletContext context) {
        try {
            // ファイルが送信されているかチェック
            if (filePart != null && filePart.getSize() > 0) {
                String submittedFileName = filePart.getSubmittedFileName();
                if (submittedFileName != null && !submittedFileName.isEmpty()) {
                    // 保存先のパスを取得
                    String uploadPath = context.getRealPath("/images");
                    //ファイルの保存パスを作成
                    String filePath = uploadPath + java.io.File.separator + submittedFileName;
                    //ファイルを保存
                    filePart.write(filePath);
                    // ファイル名を返す
                    return submittedFileName;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        // ファイルが送信されていない場合はnullを返す
        return null;
    }

    // 画像ファイル名の決定（新しい画像 or 既存画像）
    public String resolveImageName(String newImageFileName, String existingImageName) {
        if (newImageFileName != null) {
            return newImageFileName;
        }
        // 既存の画像ファイル名を返す
        return (existingImageName != null) ? existingImageName : "";
    }
}