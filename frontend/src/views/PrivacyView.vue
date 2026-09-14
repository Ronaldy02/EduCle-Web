<template>
  <div class="pp-page">
    <div class="pp-header">
      <div class="pp-logo">
        <div class="pp-logo-mark">🔑</div>
        <span class="pp-logo-name">EduClé</span>
      </div>
      <h1>Politique de confidentialité</h1>
      <p class="pp-header-meta">Dernière mise à jour : 14 septembre 2026</p>
    </div>

    <div class="pp-doc">
      <div class="pp-toc">
        <p class="pp-toc-title">Sommaire</p>
        <ol>
          <li><a href="#s1">Qui sommes-nous ?</a></li>
          <li><a href="#s2">Données collectées</a></li>
          <li><a href="#s3">Utilisation des données</a></li>
          <li><a href="#s4">Connexion via Google</a></li>
          <li><a href="#s5">Partage des données</a></li>
          <li><a href="#s6">Conservation des données</a></li>
          <li><a href="#s7">Sécurité</a></li>
          <li><a href="#s8">Droits des utilisateurs</a></li>
          <li><a href="#s9">Mineurs</a></li>
          <li><a href="#s10">Modifications</a></li>
        </ol>
      </div>

      <section id="s1">
        <h2><span class="s-num">1</span>Qui sommes-nous ?</h2>
        <p><strong>EduClé</strong> est une application éducative de quiz et de révision destinée aux élèves haïtiens du niveau fondamental et secondaire. Elle est développée et maintenue par <strong>Faustin Ronaldy</strong>, dans le cadre d'un projet de Coding Club.</p>
        <p>Contact : <a href="mailto:fronaldy4@gmail.com">fronaldy4@gmail.com</a></p>
      </section>

      <section id="s2">
        <h2><span class="s-num">2</span>Données collectées</h2>
        <p>Nous collectons uniquement les données nécessaires au fonctionnement de l'application :</p>
        <ul>
          <li><strong>Adresse e-mail</strong> — pour créer et identifier ton compte</li>
          <li><strong>Prénom / pseudo</strong> — affiché dans ton profil et le classement</li>
          <li><strong>Mot de passe</strong> — stocké sous forme chiffrée (bcrypt), jamais en clair</li>
          <li><strong>Données de progression</strong> — XP, pièces, scores par matière et chapitre</li>
          <li><strong>Date de création du compte</strong></li>
        </ul>
        <p>Si tu te connectes via Google, nous recevons ton nom et ton adresse e-mail depuis ton compte Google (voir section 4).</p>
        <div class="pp-highlight">
          Nous ne collectons pas de données de localisation, de numéro de téléphone, ni aucune donnée de paiement.
        </div>
      </section>

      <section id="s3">
        <h2><span class="s-num">3</span>Utilisation des données</h2>
        <p>Tes données sont utilisées exclusivement pour :</p>
        <ul>
          <li>Créer et gérer ton compte utilisateur</li>
          <li>Afficher ta progression, ton XP et tes scores</li>
          <li>Générer les classements entre utilisateurs</li>
          <li>Améliorer l'expérience de l'application</li>
        </ul>
        <p>Nous n'utilisons pas tes données à des fins publicitaires ou commerciales.</p>
      </section>

      <section id="s4">
        <h2><span class="s-num">4</span>Connexion via Google</h2>
        <p>EduClé propose une option de connexion via Google (OAuth 2.0). Lorsque tu choisis cette option :</p>
        <ul>
          <li>Google nous transmet ton <strong>adresse e-mail</strong> et ton <strong>nom</strong></li>
          <li>Nous ne recevons pas ton mot de passe Google</li>
          <li>Nous ne stockons pas de token Google — uniquement un JWT propre à EduClé</li>
          <li>Tu peux révoquer l'accès d'EduClé à tout moment depuis <a href="https://myaccount.google.com/permissions" target="_blank" rel="noopener">myaccount.google.com/permissions</a></li>
        </ul>
        <p>L'utilisation de Google Sign-In est régie par la <a href="https://policies.google.com/privacy" target="_blank" rel="noopener">Politique de confidentialité de Google</a>.</p>
      </section>

      <section id="s5">
        <h2><span class="s-num">5</span>Partage des données</h2>
        <p>Nous ne vendons, ne louons et ne partageons pas tes données personnelles avec des tiers, sauf dans les cas suivants :</p>
        <ul>
          <li><strong>Prestataires techniques</strong> : Supabase (base de données — hébergée sur AWS), Vercel (hébergement de l'API). Ces services traitent les données uniquement pour faire fonctionner EduClé.</li>
          <li><strong>Obligation légale</strong> : si la loi l'exige.</li>
        </ul>
      </section>

      <section id="s6">
        <h2><span class="s-num">6</span>Conservation des données</h2>
        <p>Tes données sont conservées tant que ton compte est actif. Si tu demandes la suppression de ton compte, toutes tes données personnelles seront supprimées dans un délai de <strong>30 jours</strong>.</p>
      </section>

      <section id="s7">
        <h2><span class="s-num">7</span>Sécurité</h2>
        <p>Nous mettons en œuvre les mesures suivantes pour protéger tes données :</p>
        <ul>
          <li>Mots de passe chiffrés avec bcrypt (hachage + sel)</li>
          <li>Sessions authentifiées par token JWT signé (expiration 30 jours)</li>
          <li>Connexions chiffrées via HTTPS / TLS</li>
          <li>Base de données accessible uniquement depuis le backend (réseau privé)</li>
        </ul>
      </section>

      <section id="s8">
        <h2><span class="s-num">8</span>Droits des utilisateurs</h2>
        <p>Tu as le droit de :</p>
        <ul>
          <li><strong>Accéder</strong> à tes données personnelles</li>
          <li><strong>Rectifier</strong> un prénom ou une adresse e-mail incorrects</li>
          <li><strong>Supprimer</strong> ton compte et toutes tes données</li>
          <li><strong>Exporter</strong> tes données de progression (sur demande)</li>
        </ul>
        <p>Pour exercer ces droits, contacte-nous à <a href="mailto:fronaldy4@gmail.com">fronaldy4@gmail.com</a>.</p>
      </section>

      <section id="s9">
        <h2><span class="s-num">9</span>Mineurs</h2>
        <p>EduClé est conçue pour les élèves, y compris les mineurs. Nous ne collectons aucune donnée non nécessaire au fonctionnement éducatif de l'application. Aucune publicité n'est affichée. Les parents ou tuteurs peuvent demander la suppression du compte d'un mineur en nous contactant.</p>
      </section>

      <section id="s10">
        <h2><span class="s-num">10</span>Modifications</h2>
        <p>Cette politique peut être mise à jour pour refléter des changements dans l'application ou la réglementation. En cas de modification significative, nous en informerons les utilisateurs via l'application. La date de dernière mise à jour est affichée en haut de cette page.</p>
      </section>

      <div class="pp-contact">
        <h3>Une question ?</h3>
        <p>Pour toute question relative à la confidentialité de tes données, contacte-nous directement.</p>
        <a href="mailto:fronaldy4@gmail.com">fronaldy4@gmail.com</a>
      </div>

      <p class="pp-footer">© 2026 EduClé · Application éducative haïtienne</p>
    </div>
  </div>
</template>

<script setup></script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Syne:wght@600;700;800&family=DM+Sans:opsz,wght@9..40,400;9..40,500;9..40,600&display=swap');

.pp-page {
  font-family: 'DM Sans', -apple-system, sans-serif;
  background: #F4F6FB;
  min-height: 100dvh;
  padding-bottom: 80px;
}

.pp-header {
  background: linear-gradient(148deg, #030C1F 0%, #0A1F44 50%, #1B3E96 100%);
  padding: 48px 32px 44px;
  text-align: center;
  margin-bottom: 48px;
}
.pp-logo {
  display: inline-flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 20px;
}
.pp-logo-mark {
  width: 36px; height: 36px;
  background: #F59E0B;
  border-radius: 8px;
  display: flex; align-items: center; justify-content: center;
  font-size: 18px;
}
.pp-logo-name {
  font-family: 'Syne', sans-serif;
  font-size: 22px; font-weight: 800;
  color: #fff; letter-spacing: -0.4px;
}
.pp-header h1 {
  font-family: 'Syne', sans-serif;
  font-size: clamp(22px, 4vw, 32px);
  font-weight: 700; color: #fff;
  letter-spacing: -0.5px;
  text-wrap: balance;
  margin-bottom: 10px;
}
.pp-header-meta { font-size: 13px; color: rgba(255,255,255,0.45); }

.pp-doc {
  max-width: 720px;
  margin: 0 auto;
  padding: 0 16px;
}

.pp-toc {
  background: #fff;
  border: 1px solid #DDE2F0;
  border-radius: 14px;
  padding: 24px 28px;
  margin-bottom: 16px;
}
.pp-toc-title {
  font-family: 'Syne', sans-serif;
  font-size: 13px; font-weight: 700;
  text-transform: uppercase; letter-spacing: 0.08em;
  color: #6B7A99; margin-bottom: 14px;
}
.pp-toc ol { list-style: none; counter-reset: toc; display: flex; flex-direction: column; gap: 6px; }
.pp-toc li { counter-increment: toc; }
.pp-toc a { color: #2563EB; text-decoration: none; font-size: 14px; font-weight: 500; }
.pp-toc a::before { content: counter(toc) ". "; color: #6B7A99; font-weight: 400; }
.pp-toc a:hover { text-decoration: underline; }

section {
  background: #fff;
  border: 1px solid #DDE2F0;
  border-radius: 14px;
  padding: 32px 36px;
  margin-bottom: 16px;
  scroll-margin-top: 24px;
}
section h2 {
  font-family: 'Syne', sans-serif;
  font-size: 18px; font-weight: 700;
  color: #0D1117; letter-spacing: -0.3px;
  margin-bottom: 14px;
  display: flex; align-items: center; gap: 10px;
}
.s-num {
  width: 28px; height: 28px;
  background: #2563EB;
  border-radius: 7px;
  color: #fff; font-size: 13px; font-weight: 700;
  display: flex; align-items: center; justify-content: center;
  flex-shrink: 0;
}

p { color: #3D4A62; margin-bottom: 12px; }
p:last-child { margin-bottom: 0; }
ul, ol { padding-left: 22px; color: #3D4A62; margin-bottom: 12px; }
li { margin-bottom: 6px; }
a { color: #2563EB; }

.pp-highlight {
  background: #EFF4FF;
  border-left: 3px solid #2563EB;
  border-radius: 0 8px 8px 0;
  padding: 14px 18px;
  color: #0D1B3E;
  font-size: 14px;
  margin: 16px 0;
}

.pp-contact {
  background: linear-gradient(135deg, #0A1F44, #1B3E96);
  border-radius: 14px;
  padding: 32px 36px;
  text-align: center;
  margin-top: 32px;
}
.pp-contact h3 {
  font-family: 'Syne', sans-serif;
  font-size: 18px; font-weight: 700;
  color: #fff; margin-bottom: 10px;
}
.pp-contact p { color: rgba(255,255,255,0.6); margin-bottom: 16px; }
.pp-contact a {
  display: inline-block;
  background: #F59E0B;
  color: #0D1117;
  font-weight: 600; font-size: 14px;
  padding: 10px 24px; border-radius: 10px;
  text-decoration: none;
}
.pp-contact a:hover { opacity: 0.88; }

.pp-footer {
  text-align: center;
  font-size: 12px;
  color: #6B7A99;
  margin-top: 40px;
}

@media (max-width: 600px) {
  section { padding: 22px 20px; }
  .pp-toc { padding: 18px 20px; }
  .pp-header { padding: 36px 20px 32px; }
}
</style>
