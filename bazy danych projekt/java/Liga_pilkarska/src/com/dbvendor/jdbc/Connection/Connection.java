package com.dbvendor.jdbc.Connection;

import javax.swing.*;
import java.awt.*;
import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.security.CodeSource;
import java.sql.*;
public class Connection {

    private Statement stmt;
    private String username;
    private String password;


    public Connection(String s1, String s2){

        String url = "jdbc:mysql://localhost:3306/?autoReconnect=true&useSSL=false";
        String username1 = s1;
        String password1 = s2;

        username=s1;
        password=s2;
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
        } catch (Exception ex) {

        }

        try {

            java.sql.Connection conn = DriverManager.getConnection(
                    url,username1,password1);
            stmt = conn.createStatement();

        }
        catch (SQLException e){
            System.out.println("rr");

        }

    }

    public String Select(String s){
        try {
            String all="";
            String in = s;
            ResultSet res = stmt.executeQuery(in);
            ResultSetMetaData rsmd = res.getMetaData();
            String[] tab = new String[rsmd.getColumnCount()];
            for (int i=0;i<rsmd.getColumnCount();i++){
                tab[i]=rsmd.getColumnName(i+1);
                all=all.concat(rsmd.getColumnName(i+1)).concat("\t");
            }
            all = all.concat("\n");
            int rowCount = 0;
            String l="";
            String str;
            while(res.next()){
                for (int j=0;j<tab.length;j++) {
                    str= res.getString(tab[j]);
                    if (res.wasNull()){
                        str="null";
                    }
                    l = l.concat(str).concat("\t");
                    //System.out.println(l);
                }
                all=all.concat(l).concat("\n");
                rowCount++;
                l="";
            }
            return all;

        }
        catch (SQLException e){
            System.out.println("rr");
            return "rr";
        }

    }

    public void InsUptDel(String s){
        try{
            String in = s;
            int counter = stmt.executeUpdate(in);
        }
        catch (SQLException e){
            System.out.println("rr");
        }
    }

    public void Backup(){
        try {
            CodeSource codeSource = Connection.class.getProtectionDomain().getCodeSource();
            File jarFile = new File(codeSource.getLocation().toURI().getPath());
            String jarDir = jarFile.getParentFile().getPath();

            String dbName = "liga_pilkarska";
            String dbUser = username;
            String dbPass = password;

            String folderPath = jarDir + "\\backup";

            File f1 = new File(folderPath);
            f1.mkdir();

            String savePath = "\"" + jarDir + "\\backup\\" + "backup.sql\"";

            System.out.println(savePath);
            //String executeCmd = "mysqldump -u" + dbUser + " -p" + dbPass + " --database " + dbName + " -r " + savePath;

            String executeCmd = "C:\\Program Files\\MySQL\\MySQL Workbench 6.3 CE\\mysqldump -u" + dbUser + " -p" + dbPass + " --databases " + dbName + " --routines  -r " + savePath ;

            Process runtimeProcess = Runtime.getRuntime().exec(executeCmd);
            int processComplete = runtimeProcess.waitFor();

            if (processComplete == 0) {
                JOptionPane.showMessageDialog(null, "Backup complete");
            } else {
                JOptionPane.showMessageDialog(null, "Error");
            }
        }
        catch (URISyntaxException | IOException | InterruptedException | HeadlessException ex) {
            JOptionPane.showMessageDialog(null, "Error at Restoredbfromsql" + ex.getMessage());
        }
    }
    public void Restore(String s){
        try {
            CodeSource codeSource = Connection.class.getProtectionDomain().getCodeSource();
            File jarFile = new File(codeSource.getLocation().toURI().getPath());
            String jarDir = jarFile.getParentFile().getPath();

            String dbName = "liga_pilkarska";
            String dbUser = username;
            String dbPass = password;

            String restorePath =  jarDir + "\\backup" + "\\" + s ;
            System.out.println(restorePath);
            String[] executeCmd = new String[]{"C:\\Program Files\\MySQL\\MySQL Workbench 6.3 CE\\mysql", "-u" + dbUser, "-p" + dbPass, "-e", " source " + restorePath};
            //String[] executeCmd = new String[]{"C:\\\\Program Files\\\\MySQL\\\\MySQL Workbench 6.3 CE\\\\mysqldump", "--user=" + dbUser, "--password=" + dbPass, dbName,"-e", " source "+restorePath};
            //String executeCmd = "C:\\Program Files\\MySQL\\MySQL Workbench 6.3 CE\\mysql " + " -u " + dbUser + " -p " + dbPass + " "+dbName +"<"+ restorePath;
            System.out.println(executeCmd);
            Process runtimeProcess = Runtime.getRuntime().exec(executeCmd);
            int processComplete = runtimeProcess.waitFor();

            /*NOTE: processComplete=0 if correctly executed, will contain other values if not*/
            if (processComplete == 0) {
                JOptionPane.showMessageDialog(null, "Successfully restored from SQL : " + "backup.sql");
            } else {
                JOptionPane.showMessageDialog(null, "Error at restoring");
            }


        } catch (URISyntaxException | IOException | InterruptedException | HeadlessException ex) {
            JOptionPane.showMessageDialog(null, "Error at Restoredbfromsql" + ex.getMessage());
        }
    }
}
