import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;

public class LogWindow extends JFrame {

    private JTextField login;
    private JTextField password;
    private JButton button1;
    private JButton button2;
    private JButton button3;

    public LogWindow(){
        super("logowanie");

        Font font = new Font("TimesRoman", Font.BOLD, 18);
        setLayout(new GridBagLayout());
        GridBagConstraints c = new GridBagConstraints();
        setSize(400,200);
        setLocationRelativeTo(null);

        JLabel label1 = new JLabel("login");
        label1.setFont(font);
        c.fill = GridBagConstraints.HORIZONTAL;
        c.weightx = 1;
        c.gridx = 0;
        c.gridy = 0;
        add(label1,c);

        login = new JTextField();
        login.setFont(font);
        c.fill = GridBagConstraints.HORIZONTAL;
        c.weightx = 1;
        c.gridx = 1;
        c.gridy = 0;
        add(login,c);

        JLabel label2 = new JLabel("haslo");
        label2.setFont(font);
        c.fill = GridBagConstraints.HORIZONTAL;
        c.gridx = 0;
        c.gridy = 1;
        add(label2,c);

        password = new JTextField();
        password.setFont(font);
        c.fill = GridBagConstraints.HORIZONTAL;
        c.weightx = 1;
        c.gridx = 1;
        c.gridy = 1;
        add(password,c);

        button1 = new JButton("Zaloguj (admin)");
        button1.setFont(font);
        c.fill = GridBagConstraints.HORIZONTAL;
        c.gridx = 0;
        c.gridwidth=2;
        c.gridy = 2;
        add(button1,c);

        button2 = new JButton("Zaloguj");
        button2.setFont(font);
        c.fill = GridBagConstraints.HORIZONTAL;
        c.weightx = 2;
        c.gridx = 0;
        c.gridy = 3;
        add(button2,c);

        button3 = new JButton("Bez logowania");
        button3.setFont(font);
        c.fill = GridBagConstraints.HORIZONTAL;
        c.weightx = 2;
        c.gridx = 0;
        c.gridy = 4;
        add(button3,c);

        addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent e) {
                System.exit(0);
            }
        });
        setVisible(true);

        button1.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent aActionEvent) {
                if (aActionEvent.getSource() == button1) {
                    Access3Window access = new Access3Window(login.getText(),password.getText());
                }
            }});

        button2.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent aActionEvent) {
                if (aActionEvent.getSource() == button2) {
                    Access2Window access = new Access2Window(login.getText(),password.getText());
                }
            }});

        button3.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent aActionEvent) {
                if (aActionEvent.getSource() == button3) {
                    Access1Window access = new Access1Window("user","user1");
                }
            }});

    }
}
