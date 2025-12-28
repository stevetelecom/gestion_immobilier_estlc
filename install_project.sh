#!/bin/bash

# ============================================================================
# Script d'Installation Automatique Complète
# Projet : Gestion Immobilière ESTLC
# Architecture : Laravel + Inertia.js + Vue.js (Monolithique)
# ============================================================================

echo "🏢 GESTION IMMOBILIÈRE ESTLC - Installation Automatique"
echo "========================================================="
echo ""

# Couleurs
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Variables
PROJECT_DIR=$(pwd)

# ============================================================================
# VÉRIFICATIONS PRÉALABLES
# ============================================================================
echo -e "${BLUE}🔍 Vérification de l'environnement...${NC}"

# Vérifier PHP
if ! command -v php &> /dev/null; then
    echo -e "${RED}❌ PHP n'est pas installé${NC}"
    exit 1
fi
echo -e "${GREEN}✅ PHP $(php -v | head -n 1 | cut -d " " -f 2)${NC}"

# Vérifier Composer
if ! command -v composer &> /dev/null; then
    echo -e "${RED}❌ Composer n'est pas installé${NC}"
    exit 1
fi
echo -e "${GREEN}✅ Composer installé${NC}"

# Vérifier Node.js
if ! command -v node &> /dev/null; then
    echo -e "${RED}❌ Node.js n'est pas installé${NC}"
    exit 1
fi
echo -e "${GREEN}✅ Node.js $(node -v)${NC}"

# Vérifier npm
if ! command -v npm &> /dev/null; then
    echo -e "${RED}❌ npm n'est pas installé${NC}"
    exit 1
fi
echo -e "${GREEN}✅ npm $(npm -v)${NC}"

echo ""

# ============================================================================
# CONFIGURATION LARAVEL
# ============================================================================
echo -e "${BLUE}📦 Configuration de Laravel...${NC}"

# Générer la clé d'application
php artisan key:generate --force
echo -e "${GREEN}✅ Clé d'application générée${NC}"

# Créer le lien symbolique pour le storage
php artisan storage:link
echo -e "${GREEN}✅ Lien storage créé${NC}"

# ============================================================================
# CRÉATION DES MIGRATIONS
# ============================================================================
echo -e "${BLUE}🗄️  Création des migrations...${NC}"

# Fonction pour créer une migration avec timestamp unique
create_migration() {
    local name=$1
    local timestamp=$(date +%Y_%m_%d_%H%M%S)
    sleep 1 # Assurer des timestamps différents
    echo "database/migrations/${timestamp}_${name}.php"
}

# Migration 1 : add_role_to_users_table
MIGRATION_FILE=$(create_migration "add_role_to_users_table")
cat > "$MIGRATION_FILE" << 'EOFMIGRATION'
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->enum('role', ['admin', 'proprietaire', 'locataire', 'agent'])
                  ->default('locataire')
                  ->after('password');
            $table->string('phone')->nullable()->after('role');
            $table->text('address')->nullable()->after('phone');
            $table->boolean('is_active')->default(true)->after('address');
        });
    }

    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropColumn(['role', 'phone', 'address', 'is_active']);
        });
    }
};
EOFMIGRATION
echo -e "${GREEN}✅ Migration users créée${NC}"

# Migration 2 : create_properties_table
MIGRATION_FILE=$(create_migration "create_properties_table")
cat > "$MIGRATION_FILE" << 'EOFMIGRATION'
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('properties', function (Blueprint $table) {
            $table->id();
            $table->foreignId('owner_id')->constrained('users')->onDelete('cascade');
            $table->string('title');
            $table->text('description');
            $table->enum('type', ['appartement', 'maison', 'bureau', 'studio', 'villa', 'terrain']);
            $table->string('address');
            $table->string('city');
            $table->string('country')->default('Cameroun');
            $table->decimal('surface', 10, 2);
            $table->integer('bedrooms')->default(0);
            $table->integer('bathrooms')->default(0);
            $table->decimal('price', 10, 2);
            $table->enum('status', ['disponible', 'loue', 'maintenance', 'indisponible'])->default('disponible');
            $table->boolean('is_furnished')->default(false);
            $table->json('amenities')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('properties');
    }
};
EOFMIGRATION
echo -e "${GREEN}✅ Migration properties créée${NC}"

# Migration 3 : create_property_photos_table
MIGRATION_FILE=$(create_migration "create_property_photos_table")
cat > "$MIGRATION_FILE" << 'EOFMIGRATION'
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('property_photos', function (Blueprint $table) {
            $table->id();
            $table->foreignId('property_id')->constrained()->onDelete('cascade');
            $table->string('path');
            $table->boolean('is_primary')->default(false);
            $table->integer('order')->default(0);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('property_photos');
    }
};
EOFMIGRATION
echo -e "${GREEN}✅ Migration property_photos créée${NC}"

# Migration 4 : create_contracts_table
MIGRATION_FILE=$(create_migration "create_contracts_table")
cat > "$MIGRATION_FILE" << 'EOFMIGRATION'
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('contracts', function (Blueprint $table) {
            $table->id();
            $table->string('contract_number')->unique();
            $table->foreignId('property_id')->constrained()->onDelete('cascade');
            $table->foreignId('tenant_id')->constrained('users')->onDelete('cascade');
            $table->foreignId('landlord_id')->constrained('users')->onDelete('cascade');
            $table->foreignId('agent_id')->nullable()->constrained('users')->onDelete('set null');
            
            $table->date('start_date');
            $table->date('end_date');
            $table->integer('duration_months');
            
            $table->decimal('monthly_rent', 10, 2);
            $table->decimal('deposit', 10, 2);
            $table->decimal('agency_fees', 10, 2)->nullable();
            
            $table->text('terms_and_conditions');
            $table->text('special_clauses')->nullable();
            
            $table->enum('status', ['brouillon', 'actif', 'expire', 'resilie', 'renouvele'])->default('brouillon');
            
            $table->boolean('is_signed_by_tenant')->default(false);
            $table->boolean('is_signed_by_landlord')->default(false);
            $table->timestamp('signed_at')->nullable();
            
            $table->string('contract_file')->nullable();
            
            $table->timestamps();
            $table->softDeletes();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('contracts');
    }
};
EOFMIGRATION
echo -e "${GREEN}✅ Migration contracts créée${NC}"

# Migration 5 : create_payments_table
MIGRATION_FILE=$(create_migration "create_payments_table")
cat > "$MIGRATION_FILE" << 'EOFMIGRATION'
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('payments', function (Blueprint $table) {
            $table->id();
            $table->string('payment_number')->unique();
            $table->foreignId('contract_id')->constrained()->onDelete('cascade');
            $table->foreignId('tenant_id')->constrained('users')->onDelete('cascade');
            
            $table->decimal('amount', 10, 2);
            $table->date('payment_date');
            $table->date('due_date');
            
            $table->enum('payment_method', ['especes', 'virement', 'cheque', 'mobile_money', 'carte_bancaire']);
            $table->string('transaction_reference')->nullable();
            
            $table->enum('type', ['loyer', 'caution', 'charges', 'frais_agence', 'autre']);
            $table->enum('status', ['en_attente', 'paye', 'en_retard', 'annule'])->default('en_attente');
            
            $table->text('notes')->nullable();
            $table->string('receipt_file')->nullable();
            
            $table->timestamps();
            $table->softDeletes();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('payments');
    }
};
EOFMIGRATION
echo -e "${GREEN}✅ Migration payments créée${NC}"

# Migration 6 : create_complaints_table
MIGRATION_FILE=$(create_migration "create_complaints_table")
cat > "$MIGRATION_FILE" << 'EOFMIGRATION'
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('complaints', function (Blueprint $table) {
            $table->id();
            $table->string('complaint_number')->unique();
            $table->foreignId('property_id')->constrained()->onDelete('cascade');
            $table->foreignId('tenant_id')->constrained('users')->onDelete('cascade');
            $table->foreignId('assigned_to')->nullable()->constrained('users')->onDelete('set null');
            
            $table->string('title');
            $table->text('description');
            $table->enum('category', ['plomberie', 'electricite', 'chauffage', 'securite', 'nettoyage', 'autre']);
            $table->enum('priority', ['basse', 'moyenne', 'haute', 'urgente'])->default('moyenne');
            $table->enum('status', ['nouvelle', 'en_cours', 'resolue', 'fermee'])->default('nouvelle');
            
            $table->json('photos')->nullable();
            $table->text('resolution_notes')->nullable();
            $table->timestamp('resolved_at')->nullable();
            
            $table->timestamps();
            $table->softDeletes();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('complaints');
    }
};
EOFMIGRATION
echo -e "${GREEN}✅ Migration complaints créée${NC}"

echo ""
echo -e "${GREEN}✅ Toutes les migrations créées avec succès !${NC}"
echo ""

# ============================================================================
# INSTRUCTIONS FINALES
# ============================================================================
echo -e "${YELLOW}📋 PROCHAINES ÉTAPES :${NC}"
echo ""
echo "1️⃣  Configurer la base de données dans .env"
echo "   nano .env"
echo ""
echo "2️⃣  Créer la base de données MySQL"
echo "   mysql -u root -p -e \"CREATE DATABASE gestion_immobilier_estlc;\""
echo ""
echo "3️⃣  Exécuter les migrations"
echo "   php artisan migrate:fresh --seed"
echo ""
echo "4️⃣  Lancer le serveur Laravel"
echo "   php artisan serve"
echo ""
echo "5️⃣  Dans un autre terminal, lancer Vite"
echo "   npm run dev"
echo ""
echo "6️⃣  Accéder à l'application"
echo "   http://localhost:8000"
echo ""
echo -e "${GREEN}✨ Installation terminée avec succès !${NC}"
