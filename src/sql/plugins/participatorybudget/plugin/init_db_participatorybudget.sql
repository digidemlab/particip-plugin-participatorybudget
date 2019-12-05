-- --------------------------------------------------------
-- Hôte :                        127.0.0.1
-- Version du serveur:           5.7.15-log - MySQL Community Server (GPL)
-- SE du serveur:                Win64
-- HeidiSQL Version:             9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
-- Export de données de la table pb.participatorybudget_bizstat_file : ~0 rows (environ)
/*!40000 ALTER TABLE `participatorybudget_bizstat_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `participatorybudget_bizstat_file` ENABLE KEYS */;

-- Export de données de la table pb.participatorybudget_campaign : ~0 rows (environ)
/*!40000 ALTER TABLE `participatorybudget_campaign` DISABLE KEYS */;
INSERT INTO `participatorybudget_campaign` (`id_campagne`, `code_campagne`, `title`, `description`, `active`, `code_moderation_type`, `moderation_duration`) VALUES
	(1, 'A', 'Participatory Budget 2019', 'Participatory Budget 2019', 1, 'NONE', 0);
/*!40000 ALTER TABLE `participatorybudget_campaign` ENABLE KEYS */;

-- Export de données de la table pb.participatorybudget_campaign_image : ~0 rows (environ)
/*!40000 ALTER TABLE `participatorybudget_campaign_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `participatorybudget_campaign_image` ENABLE KEYS */;

-- Export de données de la table pb.participatorybudget_campaign_moderation_type : ~3 rows (environ)
/*!40000 ALTER TABLE `participatorybudget_campaign_moderation_type` DISABLE KEYS */;
INSERT INTO `participatorybudget_campaign_moderation_type` (`id_moderation_type`, `code_moderation_type`, `libelle`) VALUES
	(1, 'NONE', 'No moderation'),
	(2, 'PUBLISH', 'Immediate publication'),
	(3, 'WAIT', 'Delayed publication');
/*!40000 ALTER TABLE `participatorybudget_campaign_moderation_type` ENABLE KEYS */;

-- Export de données de la table pb.participatorybudget_campaign_phase : ~11 rows (environ)
/*!40000 ALTER TABLE `participatorybudget_campaign_phase` DISABLE KEYS */;
INSERT INTO `participatorybudget_campaign_phase` (`id_campagne_phase`, `code_phase_type`, `code_campagne`, `start`, `end`) VALUES
	(1, 'PRE_IDEATION', 'A', '2019-08-09 00:00:00', '2019-08-22 23:59:59'),
	(2, 'IDEATION', 'A', '2019-08-23 00:00:00', '2019-12-05 23:59:59'),
	(3, 'POST_IDEATION', 'A', '2019-09-06 00:00:00', '2019-09-19 23:59:59'),
	(4, 'CO_CONSTRUCTION', 'A', '2019-09-20 00:00:00', '2019-10-03 23:59:59'),
	(5, 'PRE_SUBMIT', 'A', '2019-10-04 00:00:00', '2019-10-17 23:59:59'),
	(6, 'SUBMIT', 'A', '2019-10-18 00:00:00', '2019-10-31 23:59:59'),
	(7, 'PRE_VOTE', 'A', '2019-11-01 00:00:00', '2019-11-14 23:59:59'),
	(8, 'VOTE', 'A', '2019-11-15 00:00:00', '2019-11-28 23:59:59'),
	(9, 'POST_VOTE', 'A', '2019-11-29 00:00:00', '2019-12-12 23:59:59'),
	(10, 'PRE_RESULT', 'A', '2019-12-13 00:00:00', '2019-12-26 23:59:59'),
	(11, 'RESULT', 'A', '2019-12-27 00:00:00', '2020-01-09 23:59:59');
/*!40000 ALTER TABLE `participatorybudget_campaign_phase` ENABLE KEYS */;

-- Export de données de la table pb.participatorybudget_campaign_phase_type : ~11 rows (environ)
/*!40000 ALTER TABLE `participatorybudget_campaign_phase_type` DISABLE KEYS */;
INSERT INTO `participatorybudget_campaign_phase_type` (`id_phase_type`, `code_phase_type`, `libelle`) VALUES
	(1, 'PRE_IDEATION', 'Before ideation phase'),
	(2, 'IDEATION', 'Ideation phase open'),
	(3, 'POST_IDEATION', 'After ideation phase'),
	(4, 'CO_CONSTRUCTION', 'Co-construction phase'),
	(5, 'PRE_SUBMIT', 'Before submission phase'),
	(6, 'SUBMIT', 'View projects to be voted'),
	(7, 'PRE_VOTE', 'Before vote phase'),
	(8, 'VOTE', 'Vote phase open'),
	(9, 'POST_VOTE', 'After vote phase'),
	(10, 'PRE_RESULT', 'Before result phase'),
	(11, 'RESULT', 'Announce vote results');
/*!40000 ALTER TABLE `participatorybudget_campaign_phase_type` ENABLE KEYS */;

-- Export de données de la table pb.participatorybudget_campaign_theme : ~4 rows (environ)
/*!40000 ALTER TABLE `participatorybudget_campaign_theme` DISABLE KEYS */;
INSERT INTO `participatorybudget_campaign_theme` (`id_campagne_theme`, `code_campagne`, `code_theme`, `title`, `description`, `active`, `image_file`) VALUES
	(1, 'A', 'ENVIRONMENT', 'Environment issues', 'Environment issues', 1, NULL),
	(2, 'A', 'SOCIAL', 'Social issues', 'Social issues', 1, NULL),
	(3, 'A', 'SPORT', 'Sport', 'Sport', 1, NULL),
	(4, 'A', 'GENERAL', 'General', 'General', 1, NULL);
/*!40000 ALTER TABLE `participatorybudget_campaign_theme` ENABLE KEYS */;

-- Export de données de la table pb.participatorybudget_rgpd_treatment_log : ~0 rows (environ)
/*!40000 ALTER TABLE `participatorybudget_rgpd_treatment_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `participatorybudget_rgpd_treatment_log` ENABLE KEYS */;

-- Export de données de la table pb.participatorybudget_user_access_vote : 0 rows
/*!40000 ALTER TABLE `participatorybudget_user_access_vote` DISABLE KEYS */;
/*!40000 ALTER TABLE `participatorybudget_user_access_vote` ENABLE KEYS */;

-- Export de données de la table pb.participatorybudget_votes : ~0 rows (environ)
/*!40000 ALTER TABLE `participatorybudget_votes` DISABLE KEYS */;
/*!40000 ALTER TABLE `participatorybudget_votes` ENABLE KEYS */;

-- Export de données de la table pb.participatorybudget_votes_history : ~0 rows (environ)
/*!40000 ALTER TABLE `participatorybudget_votes_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `participatorybudget_votes_history` ENABLE KEYS */;

-- Export de données de la table pb.participatorybudget_votes_per_location : 3 rows
/*!40000 ALTER TABLE `participatorybudget_votes_per_location` DISABLE KEYS */;
INSERT INTO `participatorybudget_votes_per_location` (`id`, `localisation_ardt`, `nb_votes`) VALUES
	(1, 'area_1', 3),
	(2, 'area_2', 0),
	(3, 'area_3', 1);
/*!40000 ALTER TABLE `participatorybudget_votes_per_location` ENABLE KEYS */;

-- Export de données de la table pb.task_notify_documentbp_cf : 1 rows
/*!40000 ALTER TABLE `task_notify_documentbp_cf` DISABLE KEYS */;
INSERT INTO `task_notify_documentbp_cf` (`id_task`, `sender_name`, `sender_email`, `subject`, `message`, `recipients_cc`, `recipients_bcc`, `is_abonnes`) VALUES
	(36, 'Ville de Paris - budget participatif', 'budget.participatif@paris.fr', 'Des nouvelles des projets gagnants !', '<p>Bonjour,</p>\r\n<p>Nous avons le plaisir de vous informer que la fiche du projet &laquo; ${titre_projet!} &raquo; auquel vous &ecirc;tes associ&eacute;&middot;e,&nbsp;a &eacute;t&eacute; mise &agrave; jour :</p>\r\n<blockquote><span style="color: #0000ff;">${message_notification!}</span></blockquote>\r\n<p>Vous pouvez consulter la fiche du projet en cliquant sur le lien suivant, pour voir notamment le d&eacute;tail du planning de mise en &oelig;uvre :</p>\r\n<blockquote><a href="${url_fiche!\'\'}">fiche du projet "${titre_projet!}"</a></blockquote>\r\n<p>Pour toute question, vous pouvez consulter <span style="text-decoration: underline;"><span style="color: #0000ff;"><a style="color: #0000ff; text-decoration: underline;" href="https://budgetparticipatif.paris.fr/bp/jsp/site/Portal.jsp?page=helpdesk&amp;faq_id=3" target="_blank">la foire aux questions du budget participatif</a></span></span> ou nous &eacute;crire &agrave; <span style="text-decoration: underline;"><span style="color: #0000ff;"><a style="color: #0000ff; text-decoration: underline;" href="mailto:budgetparticipatif@paris.fr" target="_blank">budgetparticipatif@paris.fr</a></span></span></p>\r\n<p>L&rsquo;&eacute;quipe du budget participatif de la Ville de Paris</p>\r\n<p><img src="https://budgetparticipatif.paris.fr/bp/document?id=5278&amp;id_attribute=43" alt="mdp" width="103" height="123" /></p>\r\n<p>#budgetparticipatif</p>\r\n<p>Nous suivre sur <span style="text-decoration: underline;"><span style="color: #0000ff;"><a style="color: #0000ff; text-decoration: underline;" href="https://www.facebook.com/groups/NotreBudget/" target="_blank">Facebook</a></span></span> et sur <span style="text-decoration: underline;"><span style="color: #0000ff;"><a style="color: #0000ff; text-decoration: underline;" href="https://twitter.com/Paris" target="_blank">Twitter</a></span></span></p>\r\n<p>Pour param&eacute;trer les notifications que vous recevez, rendez-vous dans la rubrique &laquo; Mes notifications &raquo; de votre compte sur budgetparticipatif.paris</p>', 'ddct-mpc-site-bp@paris.fr', '', 1);
/*!40000 ALTER TABLE `task_notify_documentbp_cf` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;