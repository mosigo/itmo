package ru.obolshakova.students.itmo.yalets;

import net.sf.xfresh.core.InternalRequest;
import net.sf.xfresh.core.InternalResponse;
import net.sf.xfresh.core.Yalet;
import net.sf.xfresh.core.xml.Xmler;
import org.apache.log4j.Logger;

import java.io.File;
import java.io.FileNotFoundException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static net.sf.xfresh.core.xml.Xmler.attribute;
import static net.sf.xfresh.core.xml.Xmler.tag;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 07.03.11 1:34
 */
public class SvnChangesYalet implements Yalet {
    private static final Logger log = Logger.getLogger(SvnChangesYalet.class);

    @Override
    public void process(final InternalRequest req, final InternalResponse res) {
        res.add(new ChangesCollector().changes(req.getParameter("filter")));
    }

    private static class Entry {

        enum ChangeType {
            A, U, D, M
        }

        private static class Change {
            private final String file;
            private final ChangeType type;

            private Change(final String file, final ChangeType type) {
                this.file = file;
                this.type = type;
            }
        }

        private final String who;
        private final Date when;

        private final String comment;
        private final String rev;

        private final List<Change> changes;

        private Entry(final String who, final String rev, final Date when, final String comment, final List<Change> changes) {
            this.who = who;
            this.when = when;
            this.comment = comment;
            this.changes = changes;
            this.rev = rev;
        }
    }

    private static class ChangesCollector {
        //r10 | andrianov | 2011-02-24 11:41:16 +0300 (Thu, 24 Feb 2011) | 1 line
        private static Pattern P = Pattern.compile("r(\\d+) \\| (\\w+) \\| (.*?)\\(.*$");
        private static Pattern P1 = Pattern.compile("\\s*([ADUM])\\s+(.*)");
        private static final DateFormat F = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss Z");


        Xmler.Tag changes(final String filter) {
            Scanner s = null;
            try {
                final File file = new File("/tmp/svnlog-students");

                s = new Scanner(file);

                final List<Entry> entries = new ArrayList<Entry>();

                String who = null;
                String rev = null;
                Date date = null;
                StringBuilder comment = null;
                List<Entry.Change> changes = null;


                while (s.hasNextLine()) {
                    final String line = s.nextLine().trim();
                    if (line.equals("------------------------------------------------------------------------") ||
                        line.equals("Changed paths:")) {
                        continue;
                    }
                    final Matcher matcher = P.matcher(line.trim());
                    if (matcher.matches()) {
                        if (who != null) {
                            entries.add(new Entry(who, rev, date, comment.toString(), changes));
                        }
                        rev = matcher.group(1);
                        who = matcher.group(2);
                        try {
                            date = F.parse(matcher.group(3).trim());
                        } catch (ParseException e) {
                            throw new RuntimeException(e);
                        }
                        comment = new StringBuilder();
                        changes = new ArrayList<Entry.Change>();
                    } else if (!line.trim().isEmpty()) {
                        final Matcher fileLineMatcher = P1.matcher(line.trim());
                        if (fileLineMatcher.matches()) {
                            changes.add(new Entry.Change(fileLineMatcher.group(2), Entry.ChangeType.valueOf(fileLineMatcher.group(1))));
                        } else {
                            if (who != null) {
                                comment.append(line).append("\n");
                            }
                        }
                    }

                }

                Collections.sort(
                        entries,
                        new Comparator<Entry>() {
                            @Override
                            public int compare(final Entry o1, final Entry o2) {
                                final long time1 = o1.when.getTime();
                                final long time2 = o2.when.getTime();
                                return time1 < time2 ? 1 : (time2 < time1 ? -1 : 0);
                            }
                        }
                );
                final List<Xmler.Tag> inner = new ArrayList<Xmler.Tag>(entries.size());
                for (final Entry entry : entries) {
                    final List<Xmler.Tag> innerChanges = new ArrayList<Xmler.Tag>(entry.changes.size());
                    boolean forAddition = filter == null;
                    for (final Entry.Change change : entry.changes) {
                        if (filter != null) {
                            if (change.file.contains(filter)) {
                                forAddition = true;
                            }
                        }
                        innerChanges.add(tag("change", attribute("type", change.type.name()).and("path", change.file)));
                    }

                    if (!forAddition) {
                        continue;
                    }

                    inner.add(tag("commit", attribute("when", entry.when.toString()).and("who", entry.who).and("rev", entry.rev),
                        tag("comment", entry.comment),
                        tag("changes",innerChanges)
                    ));
                }
                return tag("history", inner);
            } catch (FileNotFoundException e) {
                log.error("", e);
            } finally {
                if (s != null) {
                    s.close();
                }
            }
            return null;
        }
    }
}
