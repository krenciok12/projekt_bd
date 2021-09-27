import com.dbvendor.jdbc.Connection.Connection;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;

public class Access2Window extends Frame{

    private Connection conn;
    private JTextArea ta1;
    private JTextArea ta2;
    private JButton button1;
    private JButton button2;
    private JScrollPane scroll1;
    private JScrollPane scroll2;

    public Access2Window(String s1,String s2){
        conn = new Connection(s1,s2);

        Font font = new Font("TimesRoman", Font.BOLD, 18);
        setLayout(new GridBagLayout());
        GridBagConstraints c = new GridBagConstraints();
        setSize(600,400);
        setLocationRelativeTo(null);
        setBackground(Color.lightGray);

        ta1 = new JTextArea();
        ta1.setRows(4);
        ta1.setBackground(Color.white);
        ta1.setFont(font);
        scroll1 = new JScrollPane(ta1);
        scroll1.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_ALWAYS);

        c.fill = GridBagConstraints.HORIZONTAL;
        c.gridwidth=4;
        c.gridx = 0;
        c.gridy = 0;
        add(scroll1,c);

        button1 = new JButton("Select");
        button1.setFont(font);
        c.fill = GridBagConstraints.HORIZONTAL;
        c.weightx = 2;
        c.gridx = 0;
        c.gridwidth=1;
        c.gridy = 1;
        add(button1,c);

        button2 = new JButton("Insert/Update/Delete");
        button2.setFont(font);
        c.fill = GridBagConstraints.HORIZONTAL;
        c.weightx = 2;
        c.gridx = 1;
        c.gridy = 1;
        add(button2,c);

        ta2 = new JTextArea();
        ta2.setRows(6);
        ta2.setBackground(Color.white);
        ta2.setFont(font);
        ta2.setEditable(false);
        scroll2 = new JScrollPane(ta2);
        scroll2.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_ALWAYS);

        c.fill = GridBagConstraints.HORIZONTAL;
        c.gridwidth=4;
        c.gridx = 0;
        c.gridy = 2;
        add(scroll2,c);

        addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent e) {
                System.exit(0);
            }
        });
        setVisible(true);

        button1.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent aActionEvent) {
                if (aActionEvent.getSource() == button1) {
                    ta2.setText(conn.Select(ta1.getText()));
                }
            }});

        button2.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent aActionEvent) {
                if (aActionEvent.getSource() == button2) {
                    conn.InsUptDel(ta1.getText());
                }
            }});
    }
}
