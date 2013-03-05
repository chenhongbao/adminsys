package chb.bean;

/**
 * Java bean class for wrapping news.
 */
public class NewsLead {

    private String authorName = "";
    private String authorEmail = "";
    private String authorTelephone = "";
    private String content = "";
    private String title = "";
    private String createTime = "";
    private String updateTime = "";

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = cleanString(authorName);
    }

    public String getAuthorEmail() {
        return authorEmail;
    }

    public void setAuthorEmail(String authorEmail) {
        this.authorEmail = cleanString(authorEmail);
    }

    public String getAuthorTelephone() {
        return authorTelephone;
    }

    public void setAuthorTelephone(String authorTelephone) {
        this.authorTelephone = cleanString(authorTelephone);
    }

    public String getContent() {
        return content;
    }

    public void setContentClean(String content) {
        this.content = cleanString(content);
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = cleanString(title);
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(String updateTime) {
        this.updateTime = updateTime;
    }

    /**
     * Clean the string to match HTML tags.
     * @param content string to be cleaned.
     * @return  a clean string with all the invalid characters converted.
     */
    public static String cleanString(String content) {
        if(content == null) {
            return "";
        }

        String result = content.replace(" ", "&nbsp;");
        result = result.replace("<", "&lt;");
        result = result.replace(">", "&gt;");
        result = result.replace("\"", "&quot;");
        result = result.replace("\n", "<br>");

        return result;
    }
}
