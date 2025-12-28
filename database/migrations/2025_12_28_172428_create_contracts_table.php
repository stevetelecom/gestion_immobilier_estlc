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
