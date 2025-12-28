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
