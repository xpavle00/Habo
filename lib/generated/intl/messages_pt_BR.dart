// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt_BR locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'pt_BR';

  static String m4(title) => "A categoria \"${title}\" já existe";

  static String m5(title) => "Categoria \"${title}\" criada com sucesso";

  static String m6(title) => "Categoria \"${title}\" deletada com sucesso";

  static String m7(title) => "Categoria \"${title}\" atualizada com sucesso";

  static String m8(current, unit) => "Atual: ${current} ${unit}";

  static String m9(title) =>
      "Tem certeza de que deseja excluir \"${title}\"?\n\nIsso removerá a categoria de todos os hábitos que a utilizam.";

  static String m10(error) => "Falha ao deletar a categoria: ${error}";

  static String m11(error) => "Falha ao salvar a categoria: ${error}";

  static String m12(title) => "Sem hábitos em \"${title}\"";

  static String m14(count) => "Categorias selecionadas (${count})";

  static String m15(target, unit) => "Objetivo: ${target} ${unit}";

  static String m16(version) => "Versão";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("Sobre"),
    "add": MessageLookupByLibrary.simpleMessage("Add"),
    "addCategory": MessageLookupByLibrary.simpleMessage("Adicionar Categoria"),
    "advancedHabitBuilding": MessageLookupByLibrary.simpleMessage(
      "Gerenciamento avançado do hábito",
    ),
    "advancedHabitBuildingDescription": MessageLookupByLibrary.simpleMessage(
      "Esta seção ajuda você a definir melhor seus hábitos utilizando o ciclo do hábito. Você pode definir gatilhos, rotinas e recompensas para cada hábito.",
    ),
    "allCategories": MessageLookupByLibrary.simpleMessage("Todas categorias"),
    "allHabitsWillBeReplaced": MessageLookupByLibrary.simpleMessage(
      "Todos os hábitos serão substituídos pelos hábitos do becape.",
    ),
    "allow": MessageLookupByLibrary.simpleMessage("Permitir"),
    "appNotifications": MessageLookupByLibrary.simpleMessage(
      "Notificações do aplicativo",
    ),
    "appNotificationsChannel": MessageLookupByLibrary.simpleMessage(
      "Canal de notificações de aplicativo",
    ),
    "archive": MessageLookupByLibrary.simpleMessage("Arquivar"),
    "archiveHabit": MessageLookupByLibrary.simpleMessage("Arquivar Hábito"),
    "archivedHabits": MessageLookupByLibrary.simpleMessage(
      "Hábitos Arquivados",
    ),
    "at7AM": MessageLookupByLibrary.simpleMessage("De 7:00AM"),
    "authenticate": MessageLookupByLibrary.simpleMessage("Autenticação"),
    "authenticationError": MessageLookupByLibrary.simpleMessage(
      "Erro de autenticação",
    ),
    "backup": MessageLookupByLibrary.simpleMessage("Becape"),
    "backupCreatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Backup criado com sucesso!",
    ),
    "backupFailed": MessageLookupByLibrary.simpleMessage("Backup malsucedido!"),
    "backupFailedError": MessageLookupByLibrary.simpleMessage(
      "ERRO: Falha ao criar o backup.",
    ),
    "biometric": MessageLookupByLibrary.simpleMessage("Biometria"),
    "biometricAuthenticationRequired": MessageLookupByLibrary.simpleMessage(
      "Autenticação por biometria obrigatória",
    ),
    "biometricAuthenticationSucceeded": MessageLookupByLibrary.simpleMessage(
      "Autenticação biométrica realizada",
    ),
    "biometricLockDisabled": MessageLookupByLibrary.simpleMessage(
      "Bloqueio por biometria desativado",
    ),
    "biometricLockEnabled": MessageLookupByLibrary.simpleMessage(
      "Bloqueio por biometria ativado",
    ),
    "biometricNotRecognized": MessageLookupByLibrary.simpleMessage(
      "Biometria não reconhecida, tente novamente",
    ),
    "biometricRequired": MessageLookupByLibrary.simpleMessage(
      "Biometria obrigatória",
    ),
    "booleanHabit": MessageLookupByLibrary.simpleMessage("Hábito binário"),
    "buildingBetterHabits": MessageLookupByLibrary.simpleMessage(
      "Construindo Hábitos Melhores",
    ),
    "buyMeACoffee": MessageLookupByLibrary.simpleMessage("Buy me a coffee"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
    "categories": MessageLookupByLibrary.simpleMessage("Categorias"),
    "category": MessageLookupByLibrary.simpleMessage("Categoria"),
    "categoryAlreadyExists": m4,
    "categoryCreatedSuccessfully": m5,
    "categoryDeletedSuccessfully": m6,
    "categoryUpdatedSuccessfully": m7,
    "close": MessageLookupByLibrary.simpleMessage("Fechar"),
    "complete": MessageLookupByLibrary.simpleMessage("Completo"),
    "congratulationsReward": MessageLookupByLibrary.simpleMessage(
      "Parabéns! Sua recompensa:",
    ),
    "copyright": MessageLookupByLibrary.simpleMessage("©2023 Habo"),
    "create": MessageLookupByLibrary.simpleMessage("Criar novo"),
    "createFirstCategory": MessageLookupByLibrary.simpleMessage(
      "Crie sua primeira categoria para organizar seus hábitos",
    ),
    "createHabit": MessageLookupByLibrary.simpleMessage("Criar Hábito"),
    "createHabitForCategory": MessageLookupByLibrary.simpleMessage(
      "Crie um hábito e atribua-o a esta categoria",
    ),
    "createYourFirstHabit": MessageLookupByLibrary.simpleMessage(
      "Crie seu primeiro hábito.",
    ),
    "cue": MessageLookupByLibrary.simpleMessage("Gatilho"),
    "cueDescription": MessageLookupByLibrary.simpleMessage(
      "é o que desencadeia o seu hábito. Pode ser uma hora específica, um local, um sentimento ou um evento.",
    ),
    "cueNumbered": MessageLookupByLibrary.simpleMessage("1. Gatilho"),
    "currentProgress": m8,
    "currentStreak": MessageLookupByLibrary.simpleMessage("Sequência atual"),
    "date": MessageLookupByLibrary.simpleMessage("Data"),
    "defineYourHabits": MessageLookupByLibrary.simpleMessage(
      "Defina seus hábitos",
    ),
    "defineYourHabitsDescription": MessageLookupByLibrary.simpleMessage(
      "Para desenvolver melhor seus hábitos, você pode definir:",
    ),
    "delete": MessageLookupByLibrary.simpleMessage("Deletar"),
    "deleteCategory": MessageLookupByLibrary.simpleMessage("Deletar categoria"),
    "deleteCategoryConfirmation": m9,
    "disclaimer": MessageLookupByLibrary.simpleMessage("Aviso Legal"),
    "do50PushUps": MessageLookupByLibrary.simpleMessage("Faça 50 flexões"),
    "doNotForgetToCheckYourHabits": MessageLookupByLibrary.simpleMessage(
      "Não esqueça de registrar seus hábitos.",
    ),
    "donateToCharity": MessageLookupByLibrary.simpleMessage(
      "Doar R\$10 para caridade",
    ),
    "done": MessageLookupByLibrary.simpleMessage("Concluído"),
    "editCategory": MessageLookupByLibrary.simpleMessage("Editar categoria"),
    "editHabit": MessageLookupByLibrary.simpleMessage("Editar Hábito"),
    "emptyList": MessageLookupByLibrary.simpleMessage("Lista vazia"),
    "enterAmount": MessageLookupByLibrary.simpleMessage("Adicionar quantidade"),
    "exercise": MessageLookupByLibrary.simpleMessage("Exercício"),
    "failedToDeleteCategory": m10,
    "failedToSaveCategory": m11,
    "featureCategoriesDesc": MessageLookupByLibrary.simpleMessage(
      "Organize hábitos com filtros de categorias",
    ),
    "featureCategoriesTitle": MessageLookupByLibrary.simpleMessage(
      "Categorias",
    ),
    "featureHomescreenWidgetTitle": MessageLookupByLibrary.simpleMessage(
      "Widget da tela inicial",
    ),
    "featureMaterialYouDesc": MessageLookupByLibrary.simpleMessage(
      "Cores dinâmicas que se adequam ao seu papel de parede",
    ),
    "featureMaterialYouTitle": MessageLookupByLibrary.simpleMessage(
      "Tema Material You (Android)",
    ),
    "fifteenMinOfVideoGames": MessageLookupByLibrary.simpleMessage(
      "15 min. jogando",
    ),
    "fileNotFound": MessageLookupByLibrary.simpleMessage(
      "Arquivo não encontrado",
    ),
    "fileTooLarge": MessageLookupByLibrary.simpleMessage(
      "Arquivo muito grande (max 10MB)",
    ),
    "fingerprint": MessageLookupByLibrary.simpleMessage("Impressões digitais"),
    "firstDayOfWeek": MessageLookupByLibrary.simpleMessage(
      "Primeiro dia da semana",
    ),
    "habit": MessageLookupByLibrary.simpleMessage("Hábito"),
    "habitArchived": MessageLookupByLibrary.simpleMessage("Hábito arquivado"),
    "habitContract": MessageLookupByLibrary.simpleMessage("Contrato de hábito"),
    "habitContractDescription": MessageLookupByLibrary.simpleMessage(
      "Embora o reforço positivo seja recomendado, algumas pessoas podem optar por um contrato de hábito. Um contrato de hábito permite que você especifique uma penalidade que será imposta caso você não consiga cumprir o hábito, e pode envolver um parceiro de responsabilidade que ajude a supervisionar seus objetivos.",
    ),
    "habitDeleted": MessageLookupByLibrary.simpleMessage("Hábito excluído."),
    "habitLoop": MessageLookupByLibrary.simpleMessage("O Ciclo do Hábito"),
    "habitLoopDescription": MessageLookupByLibrary.simpleMessage(
      "O Ciclo do Hábito é um modelo psicológico que descreve o processo de formação de hábitos. Consiste em três elementos: Gatilho, Rotina e Recompensa. A Deixa desencadeia a Rotina (uma ação habitual), que é reforçada pela Recompensa, criando um ciclo que torna o hábito mais enraizado e provável de ser repetido.",
    ),
    "habitNotifications": MessageLookupByLibrary.simpleMessage(
      "Notificações de aplicativo",
    ),
    "habitNotificationsChannel": MessageLookupByLibrary.simpleMessage(
      "Canal de notificações de hábito",
    ),
    "habitTitleEmptyError": MessageLookupByLibrary.simpleMessage(
      "O título do hábito não pode ficar vazio.",
    ),
    "habitType": MessageLookupByLibrary.simpleMessage("Tipo de hábito"),
    "habitUnarchived": MessageLookupByLibrary.simpleMessage(
      "Hábito desarquivado",
    ),
    "habits": MessageLookupByLibrary.simpleMessage("Hábitos:"),
    "habo": MessageLookupByLibrary.simpleMessage("Habo"),
    "haboNeedsPermission": MessageLookupByLibrary.simpleMessage(
      "Para funcionar corretamente, o Habo precisa de permissão para enviar notificações.",
    ),
    "haboSyncComingSoon": MessageLookupByLibrary.simpleMessage("Em breve"),
    "haboSyncDescription": MessageLookupByLibrary.simpleMessage(
      "Sincronize seus hábitos através de todos os seus dispositivos com o serviço de criptografia ponta a ponta em nuvem do Habo.",
    ),
    "haboSyncLearnMore": MessageLookupByLibrary.simpleMessage(
      "Descubra mais em habo.space/sync",
    ),
    "ifYouWantToSupport": MessageLookupByLibrary.simpleMessage(
      "Você pode apoiar o desenvolvimento do Habo em:",
    ),
    "input": MessageLookupByLibrary.simpleMessage("Entrada"),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage(
      "Arquivo de backup inválido",
    ),
    "logYourDays": MessageLookupByLibrary.simpleMessage("Registre seus dias"),
    "modify": MessageLookupByLibrary.simpleMessage("Modificar"),
    "month": MessageLookupByLibrary.simpleMessage("Mês"),
    "noArchivedHabits": MessageLookupByLibrary.simpleMessage(
      "Sem hábitos arquivados",
    ),
    "noCategoriesYet": MessageLookupByLibrary.simpleMessage(
      "Ainda não há categorias",
    ),
    "noDataAboutHabits": MessageLookupByLibrary.simpleMessage(
      "Não há dados sobre hábitos.",
    ),
    "noHabitsInCategory": m12,
    "notSoSuccessful": MessageLookupByLibrary.simpleMessage("Malsucedido"),
    "note": MessageLookupByLibrary.simpleMessage("Notas"),
    "notificationTime": MessageLookupByLibrary.simpleMessage(
      "Agendar notificação",
    ),
    "notifications": MessageLookupByLibrary.simpleMessage("Notificações"),
    "numericHabit": MessageLookupByLibrary.simpleMessage("Hábito numérico"),
    "numericHabitDescription": MessageLookupByLibrary.simpleMessage(
      "Os hábitos numéricos permitem que você acompanhe o progresso em incrementos ao longo do dia.",
    ),
    "observeYourProgress": MessageLookupByLibrary.simpleMessage(
      "Observe seu progresso",
    ),
    "ohNoSanction": MessageLookupByLibrary.simpleMessage(
      "Ah não! Sua penalidade:",
    ),
    "onboarding": MessageLookupByLibrary.simpleMessage("Introdução"),
    "partialValue": MessageLookupByLibrary.simpleMessage("Valor parcial"),
    "partialValueDescription": MessageLookupByLibrary.simpleMessage(
      "Para acompanhar o progresso em incrementos menores",
    ),
    "pleaseEnterCategoryTitle": MessageLookupByLibrary.simpleMessage(
      "Por favor, insira um título de categoria",
    ),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Política de Privacidade",
    ),
    "progress": MessageLookupByLibrary.simpleMessage("Progresso"),
    "remainderOfReward": MessageLookupByLibrary.simpleMessage(
      "Um lembrete da recompensa após uma rotina concluida com sucesso.",
    ),
    "remainderOfSanction": MessageLookupByLibrary.simpleMessage(
      "O lembrete da penalidade após uma rotina malsucedida.",
    ),
    "reset": MessageLookupByLibrary.simpleMessage("Redefinir"),
    "restore": MessageLookupByLibrary.simpleMessage("Restaurar"),
    "restoreCompletedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Restauração concluída com sucesso!",
    ),
    "restoreFailed": MessageLookupByLibrary.simpleMessage(
      "Falha na restauração!",
    ),
    "restoreFailedError": MessageLookupByLibrary.simpleMessage(
      "ERRO: Falha ao restaurar o backup.",
    ),
    "reward": MessageLookupByLibrary.simpleMessage("Recompensa"),
    "rewardDescription": MessageLookupByLibrary.simpleMessage(
      "é a gratificação ou sentimento positivo que você experimenta após realizar a Rotina, reforçando o hábito.",
    ),
    "rewardNumbered": MessageLookupByLibrary.simpleMessage("3. Recompensa"),
    "routine": MessageLookupByLibrary.simpleMessage("Rotina"),
    "routineDescription": MessageLookupByLibrary.simpleMessage(
      "é a ação que você toma em resposta à Deixa. É o hábito em si.",
    ),
    "routineNumbered": MessageLookupByLibrary.simpleMessage("2. Rotina"),
    "sanction": MessageLookupByLibrary.simpleMessage("Penalidade"),
    "save": MessageLookupByLibrary.simpleMessage("Salvar"),
    "saveProgress": MessageLookupByLibrary.simpleMessage("Salvar progresso"),
    "selectCategories": MessageLookupByLibrary.simpleMessage(
      "Selecionar categorias",
    ),
    "selectedCategories": m14,
    "setColors": MessageLookupByLibrary.simpleMessage("Personalizar cores"),
    "settings": MessageLookupByLibrary.simpleMessage("Ajustes"),
    "setupFingerprintFaceUnlock": MessageLookupByLibrary.simpleMessage(
      "Por favor ativar o desbloqueio por impressões digitais ou biometria facial nas configurações do dispositivo",
    ),
    "setupTouchIdFaceId": MessageLookupByLibrary.simpleMessage(
      "Por favor ativar o desbloqueio por impressões digitais ou biometria facial nas configurações do dispositivo",
    ),
    "showCategories": MessageLookupByLibrary.simpleMessage(
      "Mostrar categorias",
    ),
    "showMonthName": MessageLookupByLibrary.simpleMessage(
      "Mostrar nome do mês",
    ),
    "showReward": MessageLookupByLibrary.simpleMessage("Mostrar recompensa"),
    "showSanction": MessageLookupByLibrary.simpleMessage("Mostrar penalidade"),
    "skip": MessageLookupByLibrary.simpleMessage("Pular"),
    "skipDoesNotAffectStreaks": MessageLookupByLibrary.simpleMessage(
      "Pular (não afeta o ofensiva)",
    ),
    "soundEffects": MessageLookupByLibrary.simpleMessage("Efeitos sonoros"),
    "sourceCode": MessageLookupByLibrary.simpleMessage("Código-fonte (GitHub)"),
    "statistics": MessageLookupByLibrary.simpleMessage("Estatísticas"),
    "successful": MessageLookupByLibrary.simpleMessage("Bem-sucedido"),
    "targetProgress": m15,
    "termsAndConditions": MessageLookupByLibrary.simpleMessage(
      "Termos e Condições",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("Tema"),
    "topStreak": MessageLookupByLibrary.simpleMessage("Maior sequência"),
    "total": MessageLookupByLibrary.simpleMessage("Total"),
    "trackYourProgress": MessageLookupByLibrary.simpleMessage(
      "Você pode acompanhar seu progresso através do calendário em cada hábito ou na página de estatísticas.",
    ),
    "tryAgain": MessageLookupByLibrary.simpleMessage("Tente Novamente"),
    "twoDayRule": MessageLookupByLibrary.simpleMessage("Regra dos dois dias"),
    "twoDayRuleDescription": MessageLookupByLibrary.simpleMessage(
      "Com a regra dos dois dias, você pode não marcar um dia sem perder as ofensivas caso o próximo dia seja bem sucedido.",
    ),
    "unarchive": MessageLookupByLibrary.simpleMessage("Desarquivar"),
    "unarchiveHabit": MessageLookupByLibrary.simpleMessage(
      "Desarquivar Hábito",
    ),
    "undo": MessageLookupByLibrary.simpleMessage("Desfazer"),
    "unit": MessageLookupByLibrary.simpleMessage("Unidade"),
    "unknown": MessageLookupByLibrary.simpleMessage("Desconhecido"),
    "useTwoDayRule": MessageLookupByLibrary.simpleMessage(
      "Usar regra dos dois dias",
    ),
    "viewArchivedHabits": MessageLookupByLibrary.simpleMessage(
      "Visualizar hábitos arquivados",
    ),
    "warning": MessageLookupByLibrary.simpleMessage("Aviso"),
    "week": MessageLookupByLibrary.simpleMessage("Semana"),
    "whatsNewTitle": MessageLookupByLibrary.simpleMessage("O que há de novo"),
    "whatsNewVersion": m16,
    "yourCommentHere": MessageLookupByLibrary.simpleMessage("Seu texto"),
  };
}
